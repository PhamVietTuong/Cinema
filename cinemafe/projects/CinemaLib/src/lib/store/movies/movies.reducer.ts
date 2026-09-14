import { createReducer, on } from '@ngrx/store';
import { initialMoviesState } from './movies.state';
import * as MoviesActions from './movies.actions';

export const moviesReducer = createReducer(
  initialMoviesState,
  on(MoviesActions.loadNowShowing, MoviesActions.loadComingSoon, MoviesActions.loadMovies, MoviesActions.loadMovieDetail,
    state => ({ ...state, loading: true, error: null })),
  on(MoviesActions.loadNowShowingSuccess, (state, { movies, total, page }) => ({
    ...state,
    loading: false,
    nowShowing: page === 1 ? movies : [...state.nowShowing, ...movies],
    nowShowingTotal: total,
  })),
  on(MoviesActions.loadComingSoonSuccess, (state, { movies, total, page }) => ({
    ...state,
    loading: false,
    comingSoon: page === 1 ? movies : [...state.comingSoon, ...movies],
    comingSoonTotal: total,
  })),
  on(MoviesActions.loadMoviesSuccess, (state, { result }) => ({ ...state, loading: false, pagedMovies: result })),
  on(MoviesActions.loadMovieDetailSuccess, (state, { movie }) => ({ ...state, loading: false, selectedMovie: movie })),
  on(MoviesActions.loadNowShowingFailure, MoviesActions.loadComingSoonFailure, MoviesActions.loadMoviesFailure, MoviesActions.loadMovieDetailFailure,
    (state, { error }) => ({ ...state, loading: false, error })),
);
