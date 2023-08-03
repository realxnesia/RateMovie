//
//  MovieListRepositoryInterface.swift
//  RateMovie
//
//  Created by realxnesia on 02/08/23.
//

import Foundation
import RMDomainEntities

protocol MovieListRepositoryInterface {
    func getMoviesNowPlaying(_ completion: @escaping([MovieNowPlayingResponse.Result]) -> Void)
    func getMoviesFavouriteLocaly(_ completion: @escaping(_ data: [MoviesFavouritesModel]) -> Void)
    func addMovieToFavourites(which movie: MoviesFavouritesModel)
    func deleteFavorite(with id: Int)
}
