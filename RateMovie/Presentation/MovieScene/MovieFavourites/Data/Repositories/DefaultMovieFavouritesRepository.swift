//
//  DefaultMovieFavouritesRepository.swift
//  RateMovie
//
//  Created by realxnesia on 02/08/23.
//

import Foundation

final class DefaultMovieFavouritesRepository: MovieFavouritesInterface {
    private var localData: LocalMovieRepository
    
    init(localData: LocalMovieRepository) {
        self.localData = localData
    }
    
    func getListFavorite(_ completion: @escaping ([MoviesFavouritesModel]) -> Void) {
        localData.getAllFavouriteMovie { data in
            completion(data)
        }
    }
    
    func deleteFavorite(with id: Int) {
        localData.deleteFavourite(with: id)
    }
}

