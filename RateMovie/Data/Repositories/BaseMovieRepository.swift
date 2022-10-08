//
//  BaseMovieRepository.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 07/10/22.
//

import Foundation

protocol BaseMovieRepositoryProtocol {
  func getMoviesNowPlaying(_ completion: @escaping([MovieNowPlayingResponse.Result]) -> Void)
  func getSimilarMovies(movieId: Int, _ completion: @escaping([MovieIdSimilarResponse.Result]) -> Void)
  func getMovieDetails(movieId: Int, completion: @escaping(MovieDetail) -> Void)
}

final class DefaultBaseMoviewRepository: BaseMovieRepositoryProtocol {
  
  private var remoteData: DefaultBaseRemoteMovies
//  private var localData: BaseLocalMovies
  
  init() {
    self.remoteData = DefaultBaseRemoteMovies()
  }
  
}

extension DefaultBaseMoviewRepository {
  func getMoviesNowPlaying(_ completion: @escaping ([MovieNowPlayingResponse.Result]) -> Void) {
    remoteData.getMoviewNowPlaying { data in
      completion(data)
    }
  }
  
  func getSimilarMovies(movieId: Int, _ completion: @escaping ([MovieIdSimilarResponse.Result]) -> Void) {
    remoteData.getSimilarMovies(movieId: movieId) { data in
      completion(data)
    }
  }
  
  func getMovieDetails(movieId: Int, completion: @escaping (MovieDetail) -> Void) {
    remoteData.getMovieDetails(movieId: movieId) { data in
      completion(data)
    }
  }
}
