//
//  LocalMovieRepository.swift
//  RateMovie
//
//  Created by realxnesia on 30/07/23.
//

import Foundation
import RMDomainEntities

public protocol LocalMovieRepository {
  func getAllFavouriteMovie(
    completion: @escaping(_ members: [MoviesFavouritesModel]) -> Void
  )
  func getSelectedFavourite(
    _ id: Int,
    completion: @escaping(_ bool: Bool) -> Void
  )
  func addFavourite(_ favouriteModel: MoviesFavouritesModel)
  func deleteFavourite(with id: Int)
}
