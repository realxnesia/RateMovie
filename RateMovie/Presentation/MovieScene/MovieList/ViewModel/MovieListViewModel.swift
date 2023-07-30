//
//  MovieListViewModel.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 06/10/22.
//

import Foundation

protocol MovieListViewModelInput {
    func getMovieNowPlaying()
    func addMovieToFavorite(which movie: MoviesFavouritesModel)
    func deleteFavorite(with id: Int)
}

protocol MovieListViewModelOutput {
    var isLoading: Observable<Bool> { get }
    var errorMessage: Observable<String> { get }
    var movieList: Observable<[FavoriteNowPlaying]> { get }
    var movieListResultFiltered: Observable<[FavoriteNowPlaying]> { get }
    var movieListFiltered: [FavoriteNowPlaying] { get }
    var isFavorite: Observable<Bool> { get }
    
    var movieListFilteredTemp: [MovieNowPlayingResponse.Result] { get }
}

protocol MovieListViewModel: MovieListViewModelInput, MovieListViewModelOutput { }

final class DefaultMovieListViewModel: MovieListViewModel {
    var movieListFilteredTemp: [MovieNowPlayingResponse.Result] = []
    var movieListFiltered: [FavoriteNowPlaying] = []
    var movieListResultFiltered: Observable<[FavoriteNowPlaying]> = Observable([])
    
    let isLoading: Observable<Bool> = Observable(false)
    let errorMessage: Observable<String> = Observable("")
    let movieList: Observable<[FavoriteNowPlaying]> = Observable([])
    let isFavorite: Observable<Bool> = Observable(false)
    
    // MARK: Domain
    private let movieListUsecase = DefaultFetchMovieUseCase()
    init() { }
}

extension DefaultMovieListViewModel {
    func getMovieNowPlaying() {
        self.isLoading.value = true
        movieListUsecase.getMovieNowPlayingUC { [weak self] ress in
            guard let self else { return }
            self.movieListFiltered.removeAll()
            self.filteredMovies(with: ress)
        }
        
    }
    
    private func filteredMovies(with response: [MovieNowPlayingResponse.Result]) {
        movieListUsecase.getMoviesFavorite { favorites in
            let data = favorites.flatMap { favorite in
                response.filter { data in
                    return data.title == favorite.title
                }
            }
            
            let dataTemp = self.convertData(with: response, isFavorite: false)
            let favTemp = self.convertData(with: data, isFavorite: true)
            self.isLoading.value = false
            self.filtereee(movies: dataTemp, favorites: favTemp)
        }
    }
    
    private func filtereee(movies: [FavoriteNowPlaying], favorites: [FavoriteNowPlaying]) {
        var movieNow = movies
        for (indexMov, categoryMov) in movieNow.enumerated() {
            for (_, categoryFav) in favorites.enumerated() {
                if categoryFav.title == categoryMov.title {
                    movieNow.remove(at: indexMov)
                    movieNow.insert(categoryFav, at: indexMov)
                }
            }
            self.movieList.value = movieNow
        }
        
    }
        
    private func convertData(with movies: [MovieNowPlayingResponse.Result], isFavorite: Bool) -> [FavoriteNowPlaying] {
        return movies.compactMap {
            FavoriteNowPlaying(
                isFavorite: isFavorite,
                posterPath: $0.posterPath,
                adult: $0.adult,
                overview: $0.overview,
                releaseDate: $0.releaseDate,
                genreIDS: $0.genreIDS,
                id: $0.id,
                originalTitle: $0.originalTitle,
                originalLanguage: $0.originalLanguage,
                title: $0.title,
                backdropPath: $0.backdropPath,
                popularity: $0.popularity,
                voteCount: $0.voteCount,
                video: $0.video,
                voteAverage: $0.voteAverage
            )
        }
    }
    
}

extension DefaultMovieListViewModel {
    func addMovieToFavorite(which movie: MoviesFavouritesModel) {
        movieListUsecase.addMovieToFavourites(which: movie)
        self.getMovieNowPlaying()
    }
    
    func deleteFavorite(with id: Int) {
        DispatchQueue.main.async {
            self.movieListUsecase.deleteFavorite(with: id)
            self.getMovieNowPlaying()
        }
    }
}
