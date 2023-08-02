//
//  MovieDetailsInterface.swift
//  RateMovie
//
//  Created by realxnesia on 02/08/23.
//

import Foundation

protocol MovieDetailsRepositoryInterface {
    func getSimilarMovies(
        movieId: Int,
        _ completion: @escaping([MovieIdSimilarResponse.Result]) -> Void
    )
    func getSelectedMoviesFavourite(
        with id: Int,
        completion: @escaping(Bool) -> Void
    )
}
