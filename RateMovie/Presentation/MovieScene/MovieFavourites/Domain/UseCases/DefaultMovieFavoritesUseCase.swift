//
//  DefaultMovieFavoritesUseCase.swift
//  RateMovie
//
//  Created by realxnesia on 02/08/23.
//

import Foundation

final class DefaultMovieFavoritesUseCase: MovieFavoritesUseCaseProtocol {
    private var repository: MovieFavouritesInterface
    
    init(repository: MovieFavouritesInterface) {
        self.repository = repository
    }
    
    func getListFavorite(_ completion: @escaping ([MoviesFavouritesModel]) -> Void) {
        repository.getListFavorite { data in
            completion(data)
        }
    }
    
    func deleteFavorite(with id: Int) {
        repository.deleteFavorite(with: id)
    }
}
