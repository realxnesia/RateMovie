//
//  FetchMovieNowPlaying.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 07/10/22.
//

import Foundation

//TODO: Repo Interface
protocol FetchMovieProtocolUseCase {
    // The properties of value types cannot be modified within its instance methods by default.
    mutating func getMovieNowPlayingUC(_ completion: @escaping ([MovieNowPlayingResponse.Result]) -> Void)
    mutating func addMovieToFavourites(which movie: MoviesFavouritesModel)
    mutating func getMovieSelectedFavorite(with id: Int, completion: @escaping(Bool) -> Void)
    mutating func getMoviesFavorite(_ completion: @escaping(_ data: [MoviesFavouritesModel]) -> Void)
    mutating func deleteFavorite(with id: Int)
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
    
    func getMoviesFavorite(_ completion: @escaping ([MoviesFavouritesModel]) -> Void) {
        repository.getMoviesFavouriteLocaly { data in
            completion(data)
        }
    }
    
    func deleteFavorite(with id: Int) {
        repository.deleteMoviesFavourite(with: id)
    }
}
