//
//  MovieDetailsViewModel.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 07/10/22.
//

import Foundation

protocol MovieDetailsViewModelInput {
    func getMovieIdSimilar(with movieId: Int)
}

protocol MovieDetailsViewModelOutput {
    var errorMessage: Observable<String> { get }
    var movieSimilar: Observable<[MovieIdSimilarResponse.Result]> { get }
}

protocol MovieDetailsViewModel: MovieDetailsViewModelInput, MovieDetailsViewModelOutput { }

final class DefaultMovieDetailsViewModel: MovieDetailsViewModel {
    let movieSimilar: Observable<[MovieIdSimilarResponse.Result]> = Observable([])
    var errorMessage: Observable<String> = Observable("")
    
    private let movieSimilarUseCase = DefaultFetchMovieSimilarUseCase()
    
    init(movieId: Int) {
        self.getMovieIdSimilar(with: movieId)
    }
}

extension DefaultMovieDetailsViewModel {
    func getMovieIdSimilar(with movieId: Int) {
        movieSimilarUseCase.getSimilarMovieUC(with: movieId) { [weak self] data in
            self?.movieSimilar.value = data
        }
    }
    
}
