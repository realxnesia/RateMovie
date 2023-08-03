//
//  MovieListRemote.swift
//  RateMovie
//
//  Created by realxnesia on 02/08/23.
//

import Foundation
import Alamofire
import RMDomainEntities

struct DefaultMovieListRemote: MovieListRemoteInterface {
    func getMoviewNowPlaying(_ completion: @escaping ([MovieNowPlayingResponse.Result]) -> Void) {
      AF.request("\(Endpoint.baseURL)\(Endpoint.Movies.getNowPlaying)\(Endpoint.apiKey)&language=en-US&page=1",
                 method: .get,
                 encoding: JSONEncoding.default
      )
      .validate()
      .responseDecodable(of: MovieNowPlayingResponse.self) { data in
        switch data.result {
        case .success(let data):
          if let result = data.results {
            print(result)
            completion(result)
          }
        case .failure:
          break
        }
      }
    }
}
