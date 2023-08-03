//
//  FetchMovieProtocolUseCase.swift
//  RateMovie
//
//  Created by realxnesia on 02/08/23.
//

import Foundation
import RMDomainEntities

protocol FetchMovieProtocolUseCase {
    func getMovieNowPlayingUC(
        _ completion: @escaping ([MovieNowPlayingResponse.Result]) -> Void
    )
    func addMovieToFavourites(which movie: MoviesFavouritesModel)
    func getMoviesFavorite(
        _ completion: @escaping(_ data: [MoviesFavouritesModel]) -> Void
    )
    func deleteFavorite(with id: Int)
}
