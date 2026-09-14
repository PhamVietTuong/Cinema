import { Component, Inject } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Store } from '@ngrx/store';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { CinemaServiceAgent, showLoading, hideLoading, showSuccess, showException } from 'CinemaLib';

type Dto = CinemaServiceAgent.SeatTypeDTO;

export interface SeatTypeDialogData {
  theaterId: string;
  seatType: Dto | null;
}

/** Create/edit form for a theater's seat type, opened via MatDialog. Resolves `true` on save, `false` on cancel. */
@Component({
  selector: 'app-seat-type-dialog',
  standalone: false,
  templateUrl: './seat-type.dialog.html',
})
export class SeatTypeDialog {
  readonly editingId: string | null;
  form: FormGroup;

  constructor(
    private _svc: CinemaServiceAgent.HttpService,
    private _fb: FormBuilder,
    private _store: Store<any>,
    private _dialogRef: MatDialogRef<SeatTypeDialog, boolean>,
    @Inject(MAT_DIALOG_DATA) private _data: SeatTypeDialogData,
  ) {
    this.editingId = _data.seatType?.id ?? null;
    this.form = this._fb.group({
      name: [_data.seatType?.name ?? '', Validators.required],
      color: [_data.seatType?.color ?? '#808080', Validators.required],
      priceMultiplier: [_data.seatType?.priceMultiplier ?? 1, [Validators.required, Validators.min(0.1)]],
      description: [_data.seatType?.description ?? ''],
    });
  }

  save(): void {
    if (!this.form.valid) {
      this.form.markAllAsTouched();
      return;
    }
    const v = this.form.value;
    const obs = this.editingId
      ? this._svc.updateSeatType(CinemaServiceAgent.UpdateSeatTypeRequest.fromJS({ ...v, id: this.editingId, theaterId: this._data.theaterId }))
      : this._svc.createSeatType(CinemaServiceAgent.CreateSeatTypeRequest.fromJS({ ...v, theaterId: this._data.theaterId }));

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
