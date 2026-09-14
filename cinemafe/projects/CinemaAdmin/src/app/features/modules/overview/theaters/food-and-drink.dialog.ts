import { ChangeDetectorRef, Component, Inject } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Store } from '@ngrx/store';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { CinemaServiceAgent, showLoading, hideLoading, showSuccess, showException } from 'CinemaLib';
import { ImageUploadService } from '../../../../shared/image-upload.service';

type Dto = CinemaServiceAgent.FoodAndDrinkDTO;

export interface FoodAndDrinkDialogData {
  theaterId: string;
  foodAndDrink: Dto | null;
}

/** Create/edit form for a theater's food & drink item, opened via MatDialog. Resolves `true` on save, `false` on cancel. */
@Component({
  selector: 'app-food-and-drink-dialog',
  standalone: false,
  templateUrl: './food-and-drink.dialog.html',
})
export class FoodAndDrinkDialog {
  readonly editingId: string | null;
  form: FormGroup;

  uploading = false;
  uploadError = '';

  constructor(
    private _svc: CinemaServiceAgent.HttpService,
    private _fb: FormBuilder,
    private _store: Store<any>,
    private _cdr: ChangeDetectorRef,
    private _upload: ImageUploadService,
    private _dialogRef: MatDialogRef<FoodAndDrinkDialog, boolean>,
    @Inject(MAT_DIALOG_DATA) private _data: FoodAndDrinkDialogData,
  ) {
    this.editingId = _data.foodAndDrink?.id ?? null;
    this.form = this._fb.group({
      name: [_data.foodAndDrink?.name ?? '', Validators.required],
      price: [_data.foodAndDrink?.price ?? 0, [Validators.required, Validators.min(0)]],
      imageUrl: [_data.foodAndDrink?.imageUrl ?? ''],
      description: [_data.foodAndDrink?.description ?? ''],
      isAvailable: [_data.foodAndDrink?.isAvailable ?? true],
    });
  }

  onPickImage(event: Event, controlName: string): void {
    const file = (event.target as HTMLInputElement).files?.[0];
    if (!file) {
      return;
    }
    this.uploading = true;
    this.uploadError = '';
    this._upload.upload(file).subscribe({
      next: url => {
        this.form.patchValue({ [controlName]: url });
        this.uploading = false;
        this._cdr.markForCheck();
      },
      error: () => {
        this.uploadError = 'Tải ảnh thất bại.';
        this.uploading = false;
        this._cdr.markForCheck();
      },
    });
  }

  save(): void {
    if (!this.form.valid) {
      this.form.markAllAsTouched();
      return;
    }
    const v = this.form.value;
    const obs = this.editingId
      ? this._svc.updateFoodAndDrink(CinemaServiceAgent.UpdateFoodAndDrinkRequest.fromJS({ ...v, id: this.editingId, theaterId: this._data.theaterId }))
      : this._svc.createFoodAndDrink(CinemaServiceAgent.CreateFoodAndDrinkRequest.fromJS({ ...v, theaterId: this._data.theaterId }));

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
