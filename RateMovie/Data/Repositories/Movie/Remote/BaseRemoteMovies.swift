//
//  DefaultMovieRepository.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 06/10/22.
//
//- GET /movie/now_playing
//- GET /movie/{movie_id}/similar

import Foundation
import Alamofire

protocol BaseRemoteMovies {
  mutating func getMoviewNowPlaying(_ completion: @escaping([MovieNowPlayingResponse.Result]) -> Void)
  mutating func getSimilarMovies(movieId: Int, _ completion: @escaping([MovieIdSimilarResponse.Result]) -> Void)
  mutating func getMovieDetails(movieId: Int, completion: @escaping(MovieDetail) -> Void)
}

struct DefaultBaseRemoteMovies: BaseRemoteMovies {
  
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
  
  func getSimilarMovies(movieId: Int, _ completion: @escaping ([MovieIdSimilarResponse.Result]) -> Void) {
    AF.request(Endpoint.baseURL + Endpoint.Movies.baseMovie + "/\(movieId)" + Endpoint.Movies.getMovieSimilar + Endpoint.apiKey + "&language=en-US&page=1",
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
  
  func getMovieDetails(movieId: Int, completion: @escaping (MovieDetail) -> Void) {
    AF.request(Endpoint.baseURL + Endpoint.Movies.baseMovie + "\(movieId)" + Endpoint.apiKey + "&language=en-US",
               method: .get,
               encoding: JSONEncoding.default
    )
    .validate(statusCode: 200..<300)
    .responseDecodable(of: MovieDetail.self) { data in
      switch data.result {
      case .success(let data):
        completion(data)
      case .failure:
        break
      }
    }
  }
  
}

struct Endpoint {
  static let baseURL = "https://api.themoviedb.org/3"
  static let apiKey = "?api_key=cf6415e828a409f2f5d673126f0984ec"
  
  struct Movies {
    static let baseMovie = "/movie"
    static let getNowPlaying = "/movie/now_playing"
    static let getMovieSimilar = "/similar"
  }
  
  struct Images {
    static let baseImage = "https://image.tmdb.org/t/p/w500/"
  }
}
