//
//  FetchMovieNowPlaying.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 07/10/22.
//

import Foundation

protocol FetchMovieProtocolUseCase {
    func getMovieNowPlayingUC(_ completion: @escaping ([MovieNowPlayingResponse.Result]) -> Void)
    func addMovieToFavourites(which movie: MoviesFavouritesModel)
    func getMovieSelectedFavorite(with id: Int, completion: @escaping(Bool) -> Void)
    func getMoviesFavorite(_ completion: @escaping(_ data: [MoviesFavouritesModel]) -> Void)
    func deleteFavorite(with id: Int)
}

final class DefaultFetchMovieUseCase: FetchMovieProtocolUseCase {
    private let repository: BaseMovieRepositoryProtocol
    
    init(repository: BaseMovieRepositoryProtocol) {
        self.repository = repository
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
