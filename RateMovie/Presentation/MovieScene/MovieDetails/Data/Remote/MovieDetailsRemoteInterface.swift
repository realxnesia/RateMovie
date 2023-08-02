//
//  MovieDetailsRemoteInterface.swift
//  RateMovie
//
//  Created by realxnesia on 02/08/23.
//

import Foundation

protocol MovieDetailsRemoteInterface {
    func getSimilarMovies(
        movieId: Int,
        _ completion: @escaping([MovieIdSimilarResponse.Result]) -> Void
    )
}
