//
//  MovieDetailsViewController.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 07/10/22.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var rateMovieLabel: UILabel!
    
    @IBOutlet weak var overviewDescriptionLabel: UILabel!
    @IBOutlet weak var recommendationCollectionView: UICollectionView!
    @IBOutlet weak var recommendationCollectionViewHeight: NSLayoutConstraint!
}

extension MovieDetailsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        recommendationCollectionViewHeight.constant = recommendationCollectionView.contentSize.height
    }
}

extension MovieDetailsViewController {
    private func configureCollectionView() {
        recommendationCollectionView.delegate = self
        recommendationCollectionView.dataSource = self
        recommendationCollectionView.register(MovieItemCollectionViewCell.nib(), forCellWithReuseIdentifier: MovieItemCollectionViewCell.identifier)
    }
}

extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let movieItem = collectionView.dequeueReusableCell(withReuseIdentifier: MovieItemCollectionViewCell.identifier, for: indexPath) as? MovieItemCollectionViewCell {
            
            return movieItem
        }
        return UICollectionViewCell()
    }
    
}

extension MovieDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        return CGSize(width: screenSize.width/3 - 16, height: screenSize.height/3 - 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 8, bottom: 0, right: 8)
    }
}
