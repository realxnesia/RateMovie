//
//  Endpoint.swift
//  RateMovie
//
//  Created by realxnesia on 30/07/23.
//

import Foundation

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
