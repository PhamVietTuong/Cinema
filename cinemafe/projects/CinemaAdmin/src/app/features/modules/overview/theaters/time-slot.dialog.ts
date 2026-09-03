import { Component, Inject } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Store } from '@ngrx/store';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { CinemaServiceAgent, showLoading, hideLoading, showSuccess, showException } from 'CinemaLib';

type Dto = CinemaServiceAgent.TimeSlotDTO;

export interface TimeSlotDialogData {
  theaterId: string;
  timeSlot: Dto | null;
}

/** Create/edit form for a theater time slot, opened via MatDialog. Resolves `true` on save, `false` on cancel. */
@Component({
  selector: 'app-time-slot-dialog',
  standalone: false,
  templateUrl: './time-slot.dialog.html',
})
export class TimeSlotDialog {
  readonly editingId: string | null;
  form: FormGroup;

  constructor(
    private _svc: CinemaServiceAgent.HttpService,
    private _fb: FormBuilder,
    private _store: Store<any>,
    private _dialogRef: MatDialogRef<TimeSlotDialog, boolean>,
    @Inject(MAT_DIALOG_DATA) private _data: TimeSlotDialogData,
  ) {
    this.editingId = _data.timeSlot?.id ?? null;
    this.form = this._fb.group({
      name: [_data.timeSlot?.name ?? '', Validators.required],
      startTime: [_data.timeSlot?.startTime ?? '08:00', Validators.required],
      endTime: [_data.timeSlot?.endTime ?? '12:00', Validators.required],
    });
  }

  save(): void {
    if (!this.form.valid) {
      this.form.markAllAsTouched();
      return;
    }
    const v = this.form.value;
    const obs = this.editingId
      ? this._svc.updateTimeSlot(CinemaServiceAgent.UpdateTimeSlotRequest.fromJS({ ...v, id: this.editingId, theaterId: this._data.theaterId }))
      : this._svc.createTimeSlot(CinemaServiceAgent.CreateTimeSlotRequest.fromJS({ ...v, theaterId: this._data.theaterId }));

    this._store.dispatch(showLoading());
    obs.subscribe({
      next: () => {
        this._store.dispatch(showSuccess({}));
        this._dialogRef.close(true);
      },
      error: error => this._store.dispatch(showException({ error })),
    }).add(() => this._store.dispatch(hideLoading()));
  }

  cancel(): void {
    this._dialogRef.close(false);
  }
}
