//
//  MovieDetails.swift
//  RateMovie
//
//  Created by realxnesia on 02/08/23.
//

import Foundation
import Alamofire

struct DefaultMovieDetailsRemote: MovieDetailsRemoteInterface {
    func getSimilarMovies(movieId: Int, _ completion: @escaping ([MovieIdSimilarResponse.Result]) -> Void) {
      AF.request(
        Endpoint.baseURL + Endpoint.Movies.baseMovie + "/\(movieId)" + Endpoint.Movies.getMovieSimilar + Endpoint.apiKey + "&language=en-US&page=1",
        method: .get,
        encoding: JSONEncoding.default
      )
      .validate(statusCode: 200..<300)
      .responseDecodable(of: MovieIdSimilarResponse.self) { data in
        switch data.result {
        case .success(let data):
          if let result = data.results {
            completion(result)
          }
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    }
}
