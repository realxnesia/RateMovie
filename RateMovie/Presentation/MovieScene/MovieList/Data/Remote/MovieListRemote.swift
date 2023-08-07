//
//  MovieListRemote.swift
//  RateMovie
//
//  Created by realxnesia on 02/08/23.
//

import Foundation
import RMDomainEntities
import RMNetworking

struct DefaultMovieListRemote: MovieListRemoteInterface {
    func getMoviewNowPlaying(_ completion: @escaping ([MovieNowPlayingResponse.Result]) -> Void) {
      let url = "\(Endpoint.baseURL)\(Endpoint.Movies.getNowPlaying)\(Endpoint.apiKey)&language=en-US&page=1"
      NetworkingWrapper.request(
        url: url,
        method: .get,
        encoding: EncodingMode().jsonEncoding,
        headers: [:]
      ) { (response: Result<MovieNowPlayingResponse, Error>) in
        switch response {
        case .success(let data):
          if let result = data.results {
            print(result)
            completion(result)
          }
        case .failure(let failure):
          print("[X] Error: \(failure)")
        }
      }
    }
}
