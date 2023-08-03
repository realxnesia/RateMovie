//
//  FetchMovieIdSimilarProtocol.swift
//  RateMovie
//
//  Created by realxnesia on 02/08/23.
//

import Foundation
import RMDomainEntities

protocol FetchMovieIdSimilarProtocol {
    func getSimilarMovieUC(
        with movieId: Int,
        completion: @escaping ([MovieIdSimilarResponse.Result]) -> Void
    )
    func getMovieSelectedFavorite(
        with id: Int,
        completion: @escaping(Bool) -> Void
    )
}
