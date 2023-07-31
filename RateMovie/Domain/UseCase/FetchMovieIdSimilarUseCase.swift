//
//  FetchMovieIdSimilarUseCase.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 08/10/22.
//

import Foundation

protocol FetchMovieIdSimilarProtocol {
    func getSimilarMovieUC(
        with movieId: Int,
        completion: @escaping ([MovieIdSimilarResponse.Result]) -> Void
    )
    func getMovieSelectedFavorite(
        with id: Int,
        completion: @escaping(Bool) -> Void
    )
}

final class DefaultFetchMovieSimilarUseCase: FetchMovieIdSimilarProtocol {
    private var repository: BaseMovieRepositoryProtocol
    
    init(repository: BaseMovieRepositoryProtocol) {
        self.repository = repository
    }
}

extension DefaultFetchMovieSimilarUseCase {
    func getSimilarMovieUC(with movieId: Int, completion: @escaping ([MovieIdSimilarResponse.Result]) -> Void) {
        repository.getSimilarMovies(movieId: movieId) { data in
            completion(data)
        }
    }
    
    func getMovieSelectedFavorite(with id: Int, completion: @escaping (Bool) -> Void) {
        repository.getSelectedMoviesFavourite(with: id) { isFav in
            completion(isFav)
        }
    }
}
