import { Component, Inject } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Store } from '@ngrx/store';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { CinemaServiceAgent, RoomStatusValues, showLoading, hideLoading, showSuccess, showException } from 'CinemaLib';

type Dto = CinemaServiceAgent.RoomDTO;

export interface RoomDialogData {
  theaterId: string;
  room: Dto | null;
  roomTypes: CinemaServiceAgent.RoomTypeDTO[];
}

/** Create/edit form for a room, opened via MatDialog. Resolves `true` on save, `false` on cancel. */
@Component({
  selector: 'app-room-dialog',
  standalone: false,
  templateUrl: './room.dialog.html',
})
export class RoomDialog {
  readonly editingId: string | null;
  readonly statuses = RoomStatusValues;
  form: FormGroup;

  constructor(
    private _svc: CinemaServiceAgent.HttpService,
    private _fb: FormBuilder,
    private _store: Store<any>,
    private _dialogRef: MatDialogRef<RoomDialog, boolean>,
    @Inject(MAT_DIALOG_DATA) public data: RoomDialogData,
  ) {
    this.editingId = data.room?.id ?? null;
    this.form = this._fb.group({
      name: [data.room?.name ?? '', Validators.required],
      roomTypeId: [data.room?.roomTypeId ?? '', Validators.required],
      totalRows: [data.room?.totalRows ?? 1, [Validators.required, Validators.min(1)]],
      totalColumns: [data.room?.totalColumns ?? 1, [Validators.required, Validators.min(1)]],
      status: [data.room?.status ?? CinemaServiceAgent.RoomStatus.Active, Validators.required],
    });
  }

  save(): void {
    if (!this.form.valid) {
      this.form.markAllAsTouched();
      return;
    }
    const v = this.form.value;
    const obs = this.editingId
      ? this._svc.updateRoom(CinemaServiceAgent.UpdateRoomRequest.fromJS({ ...v, id: this.editingId, theaterId: this.data.theaterId }))
      : this._svc.createRoom(CinemaServiceAgent.CreateRoomRequest.fromJS({ ...v, theaterId: this.data.theaterId }));

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
