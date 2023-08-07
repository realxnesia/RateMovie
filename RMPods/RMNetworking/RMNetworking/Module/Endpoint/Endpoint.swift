//
//  Endpoint.swift
//  RateMovie
//
//  Created by realxnesia on 30/07/23.
//

import Foundation

public struct Endpoint {
  public static let baseURL = "https://api.themoviedb.org/3"
  public static let apiKey = "?api_key=cf6415e828a409f2f5d673126f0984ec"
  
  public struct Movies {
      public static let baseMovie = "/movie"
      public static let getNowPlaying = "/movie/now_playing"
      public static let getMovieSimilar = "/similar"
  }
  
  public struct Images {
    public static let baseImage = "https://image.tmdb.org/t/p/w500/"
  }
}
