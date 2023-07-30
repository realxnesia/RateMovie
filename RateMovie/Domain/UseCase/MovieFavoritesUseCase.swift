//
//  FavoriteListUseCase.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 09/10/22.
//

import Foundation

protocol MovieFavoritesUseCaseProtocol {
    func getListFavorite(_ completion: @escaping([MoviesFavouritesModel]) -> Void)
    func deleteFavorite(with id: Int)
    func getMovieSelectedFavorite(with movieId: Int, _ completion: @escaping(Bool) -> Void)
}

final class DefaultMovieFavoritesUseCase: MovieFavoritesUseCaseProtocol {
    private var repository: BaseMovieRepositoryProtocol
    
    init(repository: BaseMovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func getListFavorite(_ completion: @escaping ([MoviesFavouritesModel]) -> Void) {
        repository.getMoviesFavouriteLocaly { data in
            completion(data)
        }
    }
    
    func deleteFavorite(with id: Int) {
        repository.deleteMoviesFavourite(with: id)
    }
    
    func getMovieSelectedFavorite(with movieId: Int, _ completion: @escaping (Bool) -> Void) {
        repository.getSelectedMoviesFavourite(with: movieId) { isFav in
            completion(isFav)
        }
    }
}
