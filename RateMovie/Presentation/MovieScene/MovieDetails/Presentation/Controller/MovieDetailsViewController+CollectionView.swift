//
//  MovieDetailsViewController+CollectionView.swift
//  RateMovie
//
//  Created by realxnesia on 30/07/23.
//

import Foundation
import UIKit
import RMComponents
import RMNetworking

extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel?.movieSimilar.value.count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if let movieItem = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieItemCollectionViewCell.identifier,
            for: indexPath) as? MovieItemCollectionViewCell,
           let data = viewModel?.movieSimilar.value[indexPath.row]
        {
            movieItem.viewModel = data.toMovieListViewModel(
                baseUrl: Endpoint.Images.baseImage
            )
            movieItem.hiddenFafouriteView()
            movieItem.setView()
            return movieItem
        }
        return UICollectionViewCell()
    }
}
