//
//  FetchMovieIdSimilarUseCase.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 08/10/22.
//

import Foundation

protocol FetchMovieIdSimilarProtocol {
    mutating func getSimilarMovieUC(with movieId: Int, completion: @escaping ([MovieIdSimilarResponse.Result]) -> Void)
}

final class DefaultFetchMovieSimilarUseCase: FetchMovieIdSimilarProtocol {
    
    private var repository: BaseMovieRepositoryProtocol
    
    init() {
        self.repository = DefaultBaseMoviewRepository()
    }
}

extension DefaultFetchMovieSimilarUseCase {
    func getSimilarMovieUC(with movieId: Int, completion: @escaping ([MovieIdSimilarResponse.Result]) -> Void) {
        repository.getSimilarMovies(movieId: movieId) { data in
            completion(data)
        }
    }
}
