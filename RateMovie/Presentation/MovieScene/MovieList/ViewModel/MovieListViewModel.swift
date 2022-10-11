//
//  MovieListViewModel.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 06/10/22.
//
//- GET /movie/now_playing
//- GET /movie/{movie_id}/similar

import Foundation

protocol MovieListViewModelInput {
    func getMovieNowPlaying()
    func addMovieToFavorite(which movie: MoviesFavouritesModel)
    func getMovieSelectedFavorite(with movieId: Int)
}

protocol MovieListViewModelOutput {
    var isLoading: Observable<Bool> { get }
    var errorMessage: Observable<String> { get }
    var movieList: Observable<[MovieNowPlayingResponse.Result]> { get }
    var movieListResultFiltered: Observable<[FavoriteNowPlaying]> { get }
    var movieListFiltered: [FavoriteNowPlaying] { get }
    var isFavorite: Observable<Bool> { get }
    
    var movieListFilteredTemp: [MovieNowPlayingResponse.Result] { get }
}

protocol MovieListViewModel: MovieListViewModelInput, MovieListViewModelOutput { }

final class DefaultMovieListViewModel: MovieListViewModel {
    var movieListFilteredTemp: [MovieNowPlayingResponse.Result] = []
    
    var movieListFiltered: [FavoriteNowPlaying] = []
    
    var movieListResultFiltered: Observable<[FavoriteNowPlaying]> = Observable([])
    
    let isLoading: Observable<Bool> = Observable(false)
    let errorMessage: Observable<String> = Observable("")
    let movieList: Observable<[MovieNowPlayingResponse.Result]> = Observable([])
    let isFavorite: Observable<Bool> = Observable(false)
    
    //TODO: Domain
    private let movieListUsecase = DefaultFetchMovieUseCase()
    init() {
//        getMovieNowPlaying()
    }
    
}

extension DefaultMovieListViewModel {
    func getMovieNowPlaying() {
        self.isLoading.value = true
        movieListUsecase.getMovieNowPlayingUC { [weak self] ress in
            guard let self else { return }
            self.movieList.value = ress
            self.isLoading.value = false

            let _ = ress.map { data in
                self.movieListFiltered.removeAll()
                if let id = data.id {
                    self.movieListUsecase.getMovieSelectedFavorite(with: id) { isFavorite in
                        print("isFav: \(isFavorite)")
                        let data = FavoriteNowPlaying(isFavorite: isFavorite,
                                                      posterPath: data.posterPath,
                                                      adult: data.adult,
                                                      overview: data.overview,
                                                      releaseDate: data.releaseDate,
                                                      genreIDS: data.genreIDS,
                                                      id: data.id,
                                                      originalTitle: data.originalTitle,
                                                      originalLanguage: data.originalLanguage,
                                                      title: data.title,
                                                      backdropPath: data.backdropPath,
                                                      popularity: data.popularity,
                                                      voteCount: data.voteCount,
                                                      video: data.video,
                                                      voteAverage: data.voteAverage)
                        print("datanew \(data)")
                        self.movieListFiltered.append(data)
                    }
                    self.movieListResultFiltered.value = self.movieListFiltered
                }
                
            }
            
        }
        
    }
    
    func addMovieToFavorite(which movie: MoviesFavouritesModel) {
        movieListUsecase.addMovieToFavourites(which: movie)
    }
}

extension DefaultMovieListViewModel {
    func getMovieSelectedFavorite(with movieId: Int) {
        movieListUsecase.getMovieSelectedFavorite(with: movieId) { isFavorite in
            
        }
    }
}
