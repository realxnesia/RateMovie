//
//  FetchMovieNowPlaying.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 07/10/22.
//

import Foundation

protocol FetchMovieProtocolUseCase {
    mutating func getMovieNowPlayingUC(_ completion: @escaping ([MovieNowPlayingResponse.Result]) -> Void)
    mutating func addMovieToFavourites()
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
    
    func addMovieToFavourites() {
    }
}
