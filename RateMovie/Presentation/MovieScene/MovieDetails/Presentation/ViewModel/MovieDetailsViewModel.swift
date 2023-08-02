//
//  MovieDetailsViewModel.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 07/10/22.
//

import Foundation

protocol MovieDetailsViewModelInput {
    func didLoad()
    func getMovieId() -> Int
    func getMovieResult() -> FavoriteNowPlaying
}

protocol MovieDetailsViewModelOutput {
    var movieSimilar: Observable<[MovieIdSimilarResponse.Result]> { get }
    var isFavorite: Observable<Bool> { get }
    var errorMessage: Observable<String> { get }
}

protocol MovieDetailsViewModel: MovieDetailsViewModelInput, MovieDetailsViewModelOutput { }

final class DefaultMovieDetailsViewModel: MovieDetailsViewModel {

    let movieSimilar: Observable<[MovieIdSimilarResponse.Result]> = Observable([])
    var errorMessage: Observable<String> = Observable("")
    var isFavorite: Observable<Bool> = Observable(false)
    
    private var movieId: Int
    var movieResult: FavoriteNowPlaying
    private let movieSimilarUseCase: FetchMovieIdSimilarProtocol
    
    init(
        movieId: Int,
        movieResult: FavoriteNowPlaying,
        useCase: FetchMovieIdSimilarProtocol
    ) {
        self.movieId = movieId
        self.movieResult = movieResult
        self.movieSimilarUseCase = useCase
    }
}

extension DefaultMovieDetailsViewModel {
    func didLoad() {
        getMovieIdSimilar(with: movieId)
        getMovieSelectedFavorite(with: movieId)
    }
    
    func getMovieId() -> Int {
        return self.movieId
    }
    
    func getMovieResult() -> FavoriteNowPlaying {
        return self.movieResult
    }
}

extension DefaultMovieDetailsViewModel {
    private func getMovieIdSimilar(with movieId: Int) {
        movieSimilarUseCase.getSimilarMovieUC(with: movieId) { [weak self] data in
            self?.movieSimilar.value = data
        }
    }
    
    private func getMovieSelectedFavorite(with movieId: Int) {
        movieSimilarUseCase.getMovieSelectedFavorite(with: movieId) { isFav in
            self.isFavorite.value = isFav
        }
    }
}
