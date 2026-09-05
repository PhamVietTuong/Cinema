import { ChangeDetectorRef, Component, Input } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { Router } from '@angular/router';
import { Store } from '@ngrx/store';
import { Observable } from 'rxjs';
import { MatDialog } from '@angular/material/dialog';
import {
  CinemaServiceAgent,
  BaseTableComponent, TablePage, TableSearchCriteria,
  DialogService,
  showLoading, hideLoading, showSuccess, showException,
} from 'CinemaLib';
import { PatronCategoryDialog } from './patron-category.dialog';

type Dto = CinemaServiceAgent.PatronCategoryDTO;

/** Patron-category (Adult/Student/Senior/Child) pricing management scoped to a single theater. */
@Component({
  selector: 'app-theater-patron-categories',
  standalone: false,
  templateUrl: './theater-patron-categories.component.html',
  styleUrls: ['./theater-catalog-tab.scss'],
})
export class TheaterPatronCategoriesComponent extends BaseTableComponent<Dto> {
  @Input({ required: true }) theaterId!: string;

  seatTypes: CinemaServiceAgent.SeatTypeDTO[] = [];

  constructor(
    cd: ChangeDetectorRef,
    fb: FormBuilder,
    router: Router,
    store: Store<any>,
    private _svc: CinemaServiceAgent.HttpService,
    private _dialog: MatDialog,
    private _dialogService: DialogService,
  ) {
    super(cd, fb, router, store);
  }

  override ngOnInit(): void {
    super.ngOnInit();
    this._svc.getSeatTypes(CinemaServiceAgent.PagingSearchDTO.fromJS({
      pageIndex: 1, pageSize: 100, filters: { theaterId: this.theaterId },
    })).subscribe(r => {
      this.seatTypes = r.results ?? [];
      this._cd.markForCheck();
    });
  }

  protected override _createSearchForm(): void {
    this.searchForm = this._formBuilder.group({});
  }

  protected _search(criteria: TableSearchCriteria): Observable<TablePage<Dto>> {
    return this._svc.getPatronCategories(CinemaServiceAgent.PagingSearchDTO.fromJS({
      pageIndex: criteria.pageIndex, pageSize: criteria.pageSize, filters: criteria.filters,
    }));
  }

  protected override _extraFilters(): Record<string, unknown> {
    return { theaterId: this.theaterId };
  }

  protected override _searchStateKey(): string {
    return this._router.url + '#patronCategories';
  }

  openCreate(): void {
    this._dialog.open(PatronCategoryDialog, { width: '480px', data: { theaterId: this.theaterId, patronCategory: null, seatTypes: this.seatTypes } })
      .afterClosed().subscribe(saved => { if (saved) { this.triggerSearch(); } });
  }

  edit(item: Dto): void {
    this._dialog.open(PatronCategoryDialog, { width: '480px', data: { theaterId: this.theaterId, patronCategory: item, seatTypes: this.seatTypes } })
      .afterClosed().subscribe(saved => { if (saved) { this.triggerSearch(); } });
  }

  delete(id?: string): void {
    if (!id) {
      return;
    }
    this._dialogService.openConfirmDialog({ message: 'common.confirmDelete' })
      .afterClosed().subscribe(confirmed => {
        if (confirmed) {
          this._deleteConfirmed(id);
        }
      });
  }

  private _deleteConfirmed(id: string): void {
    this._store.dispatch(showLoading());
    this._svc.deletePatronCategory(id).subscribe({
      next: () => {
        this._store.dispatch(showSuccess({}));
        this.triggerSearch();
      },
      error: error => this._store.dispatch(showException({ error })),
    }).add(() => this._store.dispatch(hideLoading()));
  }

  /** Null means unrestricted (all seat types) — the template renders a translated "All" label. */
  allowedSeatTypeNames(item: Dto): string | null {
    if (!item.allowedSeatTypeIds?.length) {
      return null;
    }
    return this.seatTypes
      .filter(st => item.allowedSeatTypeIds!.includes(st.id!))
      .map(st => st.name)
      .join(', ');
  }
}
