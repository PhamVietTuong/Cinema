import { Movie, MovieDetail, PagedResult } from '../../models/movie.models';

export interface MoviesState {
  nowShowing: Movie[];
  nowShowingTotal: number;
  comingSoon: Movie[];
  comingSoonTotal: number;
  pagedMovies: PagedResult<Movie> | null;
  selectedMovie: MovieDetail | null;
  loading: boolean;
  error: string | null;
}

export const initialMoviesState: MoviesState = {
  nowShowing: [],
  nowShowingTotal: 0,
  comingSoon: [],
  comingSoonTotal: 0,
  pagedMovies: null,
  selectedMovie: null,
  loading: false,
  error: null,
};
