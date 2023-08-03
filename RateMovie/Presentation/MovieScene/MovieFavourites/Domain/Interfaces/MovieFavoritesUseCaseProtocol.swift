//
//  MovieFavoritesUseCaseProtocol.swift
//  RateMovie
//
//  Created by realxnesia on 02/08/23.
//

import Foundation
import RMDomainEntities

protocol MovieFavoritesUseCaseProtocol {
    func getListFavorite(
        _ completion: @escaping([MoviesFavouritesModel]) -> Void
    )
    func deleteFavorite(with id: Int)
}
