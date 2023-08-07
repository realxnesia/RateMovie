//
//  DefaultMovieDetailsRepository.swift
//  RateMovie
//
//  Created by realxnesia on 02/08/23.
//

import Foundation
import RMDomainEntities
import RMManagers

struct DefaultMovieDetailsRepository: MovieDetailsRepositoryInterface {
    private var remoteData: MovieDetailsRemoteInterface
    private var localData: LocalMovieRepository
    
    init(
      remoteData: MovieDetailsRemoteInterface,
      localData: LocalMovieRepository
    ) {
      self.remoteData = remoteData
      self.localData = localData
    }
    
    func getSimilarMovies(
        movieId: Int,
        _ completion: @escaping ([MovieIdSimilarResponse.Result]) -> Void
    ) {
        remoteData.getSimilarMovies(movieId: movieId) { data in
            completion(data)
        }
    }
    
    func getSelectedMoviesFavourite(
        with id: Int,
        completion: @escaping (Bool) -> Void
    ) {
        localData.getSelectedFavourite(id) { bool in
            completion(bool)
        }
    }
}
