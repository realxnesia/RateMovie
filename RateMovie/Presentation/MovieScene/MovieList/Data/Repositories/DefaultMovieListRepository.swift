//
//  DefaultMovieListRepository.swift
//  RateMovie
//
//  Created by realxnesia on 02/08/23.
//

import Foundation
import RMDomainEntities
import RMManagers

final class DefaultMovieListRepository: MovieListRepositoryInterface {
    private var remoteData: MovieListRemoteInterface
    private var localData: LocalMovieRepository
    
    init(
      remoteData: MovieListRemoteInterface,
      localData: LocalMovieRepository
    ) {
      self.remoteData = remoteData
      self.localData = localData
    }
}

extension DefaultMovieListRepository {
    func getMoviesNowPlaying(_ completion: @escaping ([MovieNowPlayingResponse.Result]) -> Void) {
        remoteData.getMoviewNowPlaying { data in
            completion(data)
        }
    }
}

extension DefaultMovieListRepository {
    func getMoviesFavouriteLocaly(_ completion: @escaping ([MoviesFavouritesModel]) -> Void) {
        localData.getAllFavouriteMovie { data in
            completion(data)
        }
    }
    func addMovieToFavourites(which movie: MoviesFavouritesModel) {
        localData.addFavourite(movie)
    }
    
    func deleteFavorite(with id: Int) {
        localData.deleteFavourite(with: id)
    }
}
