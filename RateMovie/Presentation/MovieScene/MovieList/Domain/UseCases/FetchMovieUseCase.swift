//
//  FetchMovieNowPlaying.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 07/10/22.
//

import Foundation
import RMDomainEntities

final class DefaultFetchMovieUseCase: FetchMovieProtocolUseCase {
    private let repository: MovieListRepositoryInterface
    
    init(repository: MovieListRepositoryInterface) {
        self.repository = repository
    }
}

extension DefaultFetchMovieUseCase {
    func getMovieNowPlayingUC(_ completion: @escaping ([MovieNowPlayingResponse.Result]) -> Void) {
        repository.getMoviesNowPlaying { data in
            completion(data)
        }
    }
}

extension DefaultFetchMovieUseCase {
    func getMoviesFavorite(_ completion: @escaping ([MoviesFavouritesModel]) -> Void) {
        repository.getMoviesFavouriteLocaly { data in
            completion(data)
        }
    }
    
    func addMovieToFavourites(which movie: MoviesFavouritesModel) {
        repository.addMovieToFavourites(which: movie)
    }
    
    func deleteFavorite(with id: Int) {
        repository.deleteFavorite(with: id)
    }
}
