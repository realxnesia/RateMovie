//
//  MovieListRemoteInterface.swift
//  RateMovie
//
//  Created by realxnesia on 02/08/23.
//

import Foundation

protocol MovieListRemoteInterface {
    func getMoviewNowPlaying(_ completion: @escaping([MovieNowPlayingResponse.Result]) -> Void)
}
