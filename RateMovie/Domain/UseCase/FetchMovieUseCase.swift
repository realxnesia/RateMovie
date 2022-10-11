//
//  FetchMovieNowPlaying.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 07/10/22.
//

import Foundation

protocol FetchMovieProtocolUseCase {
    mutating func getMovieNowPlayingUC(_ completion: @escaping ([MovieNowPlayingResponse.Result]) -> Void)
    mutating func addMovieToFavourites(which movie: MoviesFavouritesModel)
    mutating func getMovieSelectedFavorite(with id: Int, completion: @escaping(Bool) -> Void)
}

final class DefaultFetchMovieUseCase: FetchMovieProtocolUseCase {
    private var repository: BaseMovieRepositoryProtocol
    
    init() {
        self.repository = DefaultBaseMoviewRepository()
    }
}

extension DefaultFetchMovieUseCase {
    func getMovieNowPlayingUC(_ completion: @escaping ([MovieNowPlayingResponse.Result]) -> Void) {
        repository.getMoviesNowPlaying { data in
            completion(data)
        }
    }
    
    func addMovieToFavourites(which movie: MoviesFavouritesModel) {
        repository.addMoviesFavorite(movie)
    }
}

extension DefaultFetchMovieUseCase {
    func getMovieSelectedFavorite(with id: Int, completion: @escaping (Bool) -> Void) {
        repository.getSelectedMoviesFavourite(with: id) { isFavorite in
            completion(isFavorite)
        }
    }

}
