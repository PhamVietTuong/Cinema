import { Component, Inject } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Store } from '@ngrx/store';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { CinemaServiceAgent, showLoading, hideLoading, showSuccess, showException } from 'CinemaLib';

type Dto = CinemaServiceAgent.PatronCategoryDTO;

export interface PatronCategoryDialogData {
  theaterId: string;
  patronCategory: Dto | null;
}

/** Create/edit form for a theater's patron category (Adult/Student/Senior/Child), opened via MatDialog. Resolves `true` on save, `false` on cancel. */
@Component({
  selector: 'app-patron-category-dialog',
  standalone: false,
  templateUrl: './patron-category.dialog.html',
})
export class PatronCategoryDialog {
  readonly editingId: string | null;
  form: FormGroup;

  constructor(
    private _svc: CinemaServiceAgent.HttpService,
    private _fb: FormBuilder,
    private _store: Store<any>,
    private _dialogRef: MatDialogRef<PatronCategoryDialog, boolean>,
    @Inject(MAT_DIALOG_DATA) private _data: PatronCategoryDialogData,
  ) {
    this.editingId = _data.patronCategory?.id ?? null;
    this.form = this._fb.group({
      name: [_data.patronCategory?.name ?? '', Validators.required],
      discountPercent: [_data.patronCategory?.discountPercent ?? 0, [Validators.required, Validators.min(0), Validators.max(100)]],
      isActive: [_data.patronCategory?.isActive ?? true],
      description: [_data.patronCategory?.description ?? ''],
    });
  }

  save(): void {
    if (!this.form.valid) {
      this.form.markAllAsTouched();
      return;
    }
    const v = this.form.value;
    const obs = this.editingId
      ? this._svc.updatePatronCategory(CinemaServiceAgent.UpdatePatronCategoryRequest.fromJS({ ...v, id: this.editingId, theaterId: this._data.theaterId }))
      : this._svc.createPatronCategory(CinemaServiceAgent.CreatePatronCategoryRequest.fromJS({ ...v, theaterId: this._data.theaterId }));

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
