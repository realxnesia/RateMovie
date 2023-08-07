//
//  MovieDetails.swift
//  RateMovie
//
//  Created by realxnesia on 02/08/23.
//

import Foundation
import RMDomainEntities
import RMNetworking

struct DefaultMovieDetailsRemote: MovieDetailsRemoteInterface {
    func getSimilarMovies(
      movieId: Int, _
      completion: @escaping ([MovieIdSimilarResponse.Result]) -> Void
    ) {
      let url = Endpoint.baseURL + Endpoint.Movies.baseMovie + "/\(movieId)" + Endpoint.Movies.getMovieSimilar + Endpoint.apiKey + "&language=en-US&page=1"
      NetworkingWrapper.request(
        url: url,
        method: .get,
        encoding: EncodingMode().jsonEncoding,
        headers: [:]) { (response: Result<MovieIdSimilarResponse, Error>) in
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
