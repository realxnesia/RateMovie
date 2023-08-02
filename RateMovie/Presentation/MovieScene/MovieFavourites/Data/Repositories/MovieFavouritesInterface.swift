//
//  MovieFavouritesInterface.swift
//  RateMovie
//
//  Created by realxnesia on 02/08/23.
//

import Foundation

protocol MovieFavouritesInterface {
    func getListFavorite(
        _ completion: @escaping([MoviesFavouritesModel]) -> Void
    )
    func deleteFavorite(with id: Int)
}