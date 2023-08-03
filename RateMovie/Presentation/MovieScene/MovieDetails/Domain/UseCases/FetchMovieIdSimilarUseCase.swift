//
//  FetchMovieIdSimilarUseCase.swift
//  RateMovie
//
//  Created by realxnesia on 02/08/23.
//

import Foundation
import RMDomainEntities

final class DefaultFetchMovieSimilarUseCase: FetchMovieIdSimilarProtocol {
    private var repository: MovieDetailsRepositoryInterface
    
    init(repository: MovieDetailsRepositoryInterface) {
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
