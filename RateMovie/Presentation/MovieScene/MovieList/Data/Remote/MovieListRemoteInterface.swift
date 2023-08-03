//
//  MovieListRemoteInterface.swift
//  RateMovie
//
//  Created by realxnesia on 02/08/23.
//

import Foundation
import RMDomainEntities

protocol MovieListRemoteInterface {
    func getMoviewNowPlaying(_ completion: @escaping([MovieNowPlayingResponse.Result]) -> Void)
}
