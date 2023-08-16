//
//  MovieListViewController+CollectionView.swift
//  RateMovie
//
//  Created by realxnesia on 30/07/23.
//

import Foundation
import UIKit
import RMComponents
import RMDomainEntities
import RMManagers
import RMNetworking

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel?.movieList.value.count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let movieCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MovieItemCollectionViewCell.identifier,
                for: indexPath
            ) as? MovieItemCollectionViewCell
        else { return UICollectionViewCell() }
        let data = viewModel?.movieList.value[indexPath.row]
        movieCell.viewModel = data?.toMovieListViewModel(
            baseUrl: Endpoint.Images.baseImage
        )
        movieCell.setView()
        movieCell.onFavouriteTapped = { [weak self] in
            if let isFavorite = data?.isFavorite {
                if isFavorite {
                    guard let id = data?.id else { return }
                    self?.viewModel?.deleteFavorite(with: id)
                    movieCell.movieFavoriteImageView.image = UIImage(
                        systemName: "bookmark"
                    )
                } else {
                    guard
                        let selectedData = data?.moviesFavouriteModel
                    else { return }
                    self?.viewModel?.addMovieToFavorite(which: selectedData)
                    movieCell.movieFavoriteImageView.image = UIImage(
                        systemName: "bookmark.fill"
                    )
                }
            }
        }
        return movieCell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard
            let data = viewModel?.movieList.value[indexPath.row]
        else { return }
        let vc = MovieDetailsViewController()
        if let movieId = data.id {
            let vm = DefaultMovieDetailsViewModel(
                movieId: movieId,
                movieResult: data,
                useCase: DefaultFetchMovieSimilarUseCase(
                    repository: DefaultMovieDetailsRepository(
                        remoteData: DefaultMovieDetailsRemote(),
                        localData: CoreDataMovieDataStorage()
                    )
                )
            )
            vc.viewModel = vm
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
