import { ChangeDetectorRef, Component, Inject } from '@angular/core';
import { TranslateService } from '@ngx-translate/core';
import { AbstractControl, FormBuilder, FormGroup, ValidationErrors, Validators } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { CinemaServiceAgent, DialogService, ProjectionFormValues, ShowTimeTypeValues, apiErrorMessage } from 'CinemaLib';

type Dto = CinemaServiceAgent.ShowTimeDTO;

export interface ShowTimeDialogData {
  showTime: Dto | null;
  weekStart: Date;
  movies: CinemaServiceAgent.MovieDTO[];
  theaters: CinemaServiceAgent.TheaterDTO[];
  rooms: CinemaServiceAgent.RoomDTO[];
}

/** Create/edit form for a showtime, opened via MatDialog. Resolves `true` if saved or deleted, `false` on cancel. */
@Component({
  selector: 'app-show-time-dialog',
  standalone: false,
  templateUrl: './show-time.dialog.html',
  styleUrl: './show-time.dialog.scss',
})
export class ShowTimeDialog {
  private _svc: CinemaServiceAgent.HttpService;
  private _translate: TranslateService;
  private _dialogService: DialogService;
  private _cdr: ChangeDetectorRef;
  private _dialogRef: MatDialogRef<ShowTimeDialog, boolean>;

  readonly editingId: string | null;
  readonly projectionForms = ProjectionFormValues;
  readonly showTimeTypes = ShowTimeTypeValues;
  formError: string | null = null;

  /** Today as yyyy-MM-dd — the earliest date a new showtime may be scheduled on. */
  get todayYmd(): string { return this._ymd(new Date()); }

  /**
   * Blocks scheduling a new showtime in the past. Editing stays unrestricted: an admin may be
   * correcting the record of a screening that already ran, which is also what the API allows
   * (ShowTimeManager only passes mustBeFuture on create).
   */
  private _notPastOnCreate = (control: AbstractControl): ValidationErrors | null => {
    if (this.editingId || !control.value) { return null; }
    return control.value < this.todayYmd ? { pastDate: true } : null;
  };

  form: FormGroup;

  constructor(
    svc: CinemaServiceAgent.HttpService,
    fb: FormBuilder,
    cdr: ChangeDetectorRef,
    translate: TranslateService,
    dialogService: DialogService,
    dialogRef: MatDialogRef<ShowTimeDialog, boolean>,
    @Inject(MAT_DIALOG_DATA) public data: ShowTimeDialogData,
  ) {
    this._svc = svc;
    this._cdr = cdr;
    this._translate = translate;
    this._dialogService = dialogService;
    this._dialogRef = dialogRef;

    const st = data.showTime;
    this.editingId = st?.id ?? null;

    let dateValue = '';
    let startValue = '';
    let endValue = '';
    let theaterIdValue = '';
    if (st?.startTime && st?.endTime) {
      const start = new Date(st.startTime);
      const end = new Date(st.endTime);
      dateValue = this._ymd(start);
      startValue = this._hm(start);
      endValue = this._hm(end);
      theaterIdValue = data.rooms.find(r => r.id === st.roomId)?.theaterId ?? '';
    } else {
      // Anchor a new showtime on the visible week, but never before today — a new showtime
      // cannot be scheduled in the past, so pre-filling a past date from a back-navigated
      // week would open the dialog already invalid.
      const today = new Date();
      const weekEnd = this._addDays(data.weekStart, 7);
      const isThisWeek = today >= data.weekStart && today < weekEnd;
      const anchor = isThisWeek || data.weekStart < today ? today : data.weekStart;
      dateValue = this._ymd(anchor);
    }

    this.form = fb.group({
      movieId: [st?.movieId ?? '', Validators.required],
      date: [dateValue, [Validators.required, this._notPastOnCreate]],
      start: [startValue, Validators.required],
      end: [endValue, Validators.required],
      projectionForm: [st?.projectionForm ?? CinemaServiceAgent.ProjectionForm.TwoD, Validators.required],
      showTimeType: [st?.showTimeType ?? CinemaServiceAgent.ShowTimeType.Normal, Validators.required],
      theaterId: [theaterIdValue, Validators.required],
      roomId: [st?.roomId ?? '', Validators.required],
      basePrice: [st?.basePrice ?? 75000, [Validators.required, Validators.min(0)]],
      isActive: [st?.isActive ?? true],
    });
  }

  /** Rooms of the picked theater. Empty until one is picked, so the two selects cascade. */
  get roomsForTheater(): CinemaServiceAgent.RoomDTO[] {
    const theaterId = this.form.value.theaterId;
    return theaterId ? this.data.rooms.filter(r => r.theaterId === theaterId) : [];
  }

  /** A room belongs to exactly one theater, so switching theater invalidates the picked room. */
  onTheaterChange(): void {
    const roomId = this.form.value.roomId;
    if (roomId && !this.roomsForTheater.some(r => r.id === roomId)) {
      this.form.patchValue({ roomId: '' });
    }
  }

  moviePoster(id?: string): string | undefined { return this.data.movies.find(m => m.id === id)?.posterUrl; }

  save(): void {
    if (!this.form.valid) { this.form.markAllAsTouched(); return; }
    const v = this.form.value;
    const payload = {
      movieId: v.movieId,
      // Append 'Z' so the picked wall-clock time is preserved end-to-end: the generated
      // DTO serialises Date via toISOString(), so without this the value is shifted by the
      // browser's UTC offset on save and again on read (e.g. 16:00 → 09:00).
      startTime: `${v.date}T${v.start}:00Z`,
      endTime: `${v.date}T${v.end}:00Z`,
      projectionForm: v.projectionForm,
      showTimeType: v.showTimeType,
      // theaterId is a UI-only cascade field; the API derives the theater from the room.
      roomId: v.roomId,
      basePrice: Number(v.basePrice),
      isActive: v.isActive,
    };
    const obs = this.editingId
      ? this._svc.updateShowTime(CinemaServiceAgent.UpdateShowTimeRequest.fromJS({ ...payload, id: this.editingId }))
      : this._svc.createShowTime(CinemaServiceAgent.CreateShowTimeRequest.fromJS(payload));
    this.formError = null;
    obs.subscribe({
      next: () => this._dialogRef.close(true),
      error: e => this._showError(e, 'showTimes.saveFailed'),
    });
  }

  deleteCurrent(): void {
    if (!this.editingId) { return; }
    this._dialogService.openConfirmDialog({ message: 'showTimes.confirmDelete' })
      .afterClosed().subscribe(confirmed => {
        if (confirmed) {
          this._deleteConfirmed();
        }
      });
  }

  private _deleteConfirmed(): void {
    const id = this.editingId;
    if (!id) { return; }
    this.formError = null;
    this._svc.deleteShowTime(id).subscribe({
      next: () => this._dialogRef.close(true),
      error: e => this._showError(e, 'showTimes.deleteFailed'),
    });
  }

  cancel(): void {
    this._dialogRef.close(false);
  }

  /** Zoneless app: nothing re-renders off an rxjs error callback without markForCheck. */
  private _showError(err: unknown, fallbackKey: string): void {
    this.formError = apiErrorMessage(err, this._translate.instant(fallbackKey));
    this._cdr.markForCheck();
  }

  private _pad(n: number): string { return `${n}`.padStart(2, '0'); }
  private _hm(d: Date): string { return `${this._pad(d.getHours())}:${this._pad(d.getMinutes())}`; }
  private _ymd(d: Date): string { return `${d.getFullYear()}-${this._pad(d.getMonth() + 1)}-${this._pad(d.getDate())}`; }
  private _addDays(d: Date, n: number): Date { const r = new Date(d); r.setDate(r.getDate() + n); return r; }
}
