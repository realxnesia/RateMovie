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
}

protocol MovieListViewModelOutput {
    var isLoading: Observable<Bool> { get }
    var errorMessage: Observable<String> { get }
    var movieList: Observable<[MovieNowPlayingResponse.Result]> { get }
}

protocol MovieListViewModel: MovieListViewModelInput, MovieListViewModelOutput { }

final class DefaultMovieListViewModel: MovieListViewModel {
    let isLoading: Observable<Bool> = Observable(false)
    let errorMessage: Observable<String> = Observable("")
    let movieList: Observable<[MovieNowPlayingResponse.Result]> = Observable([])
    
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
        }
    }
    
    func addMovieToFavorite(which movie: MoviesFavouritesModel) {
        movieListUsecase.addMovieToFavourites(which: movie)
    }
}
