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
  
  func getMoviesFavouriteLocaly(_ completion: @escaping(_ data: [MoviesFavouritesModel]) -> Void)
  func getSelectedMoviesFavourite(with id: Int, completion: @escaping(Bool) -> Void)
  func addMoviesFavorite(_ favouriteData: MoviesFavouritesModel)
  func deleteMoviesFavourite(with id: Int)
}

final class DefaultBaseMoviewRepository: BaseMovieRepositoryProtocol {
  //TODO: Direct to the Class
  private var remoteData: DefaultBaseRemoteMovies
  private var localData: DefaultBaseLocalMovies
  
  init(remoteData: DefaultBaseRemoteMovies = DefaultBaseRemoteMovies(),
       localData: DefaultBaseLocalMovies = DefaultBaseLocalMovies()) {
    self.remoteData = remoteData
    self.localData = localData
  }
  
}

//MARK: - Remote
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

//MARK: - Local
extension DefaultBaseMoviewRepository {
  func getMoviesFavouriteLocaly(_ completion: @escaping ([MoviesFavouritesModel]) -> Void) {
    localData.getAllFavouriteMovie { data in
      completion(data)
    }
  }
  
  func addMoviesFavorite(_ favouriteData: MoviesFavouritesModel) {
    do {
      try localData.addFavourite(favouriteData)
    } catch {
      print(error.localizedDescription)
    }
  }
  
  func deleteMoviesFavourite(with id: Int) {
    do {
      try localData.deleteFavourite(with: id)
    } catch {
      print(error.localizedDescription)
    }
  }
  
  func getSelectedMoviesFavourite(with id: Int, completion: @escaping (Bool) -> Void) {
    localData.getSelectedFavourite(id) { isFavorite in
      completion(isFavorite)
    }
  }
}
