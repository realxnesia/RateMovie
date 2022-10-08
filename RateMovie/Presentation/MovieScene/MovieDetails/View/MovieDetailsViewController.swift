//
//  MovieDetailsViewController.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 07/10/22.
//

import UIKit
import Kingfisher

class MovieDetailsViewController: UIViewController, ClearNavBar {
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var rateMovieLabel: UILabel!
    
    @IBOutlet weak var overviewDescriptionLabel: UILabel!
    @IBOutlet weak var recommendationCollectionView: UICollectionView!
    @IBOutlet weak var recommendationCollectionViewHeight: NSLayoutConstraint!
    
    var movieResult: MovieNowPlayingResponse.Result?
}

extension MovieDetailsViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBackground()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setupView()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        recommendationCollectionViewHeight.constant = recommendationCollectionView.contentSize.height
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        resetNavigationBackground()
    }
}

extension MovieDetailsViewController {
    private func configureCollectionView() {
        recommendationCollectionView.delegate = self
        recommendationCollectionView.dataSource = self
        recommendationCollectionView.register(MovieItemCollectionViewCell.nib(), forCellWithReuseIdentifier: MovieItemCollectionViewCell.identifier)
    }
    
    private func setupView() {
        if let url = movieResult?.backdropPath, let imageUrl = URL(string: Endpoint.Images.baseImage + url) {
            headerImageView.kf.setImage(with: imageUrl, placeholder: UIImage.init(named: "outket_kf"), options: [.transition(.fade(0))], progressBlock: nil, completionHandler: nil)
        }
        
        if let url = movieResult?.posterPath, let imageUrl = URL(string: Endpoint.Images.baseImage + url) {
            contentImageView.kf.setImage(with: imageUrl, placeholder: UIImage.init(named: "outket_kf"), options: [.transition(.fade(0))], progressBlock: nil, completionHandler: nil)
        }
        
        titleMovieLabel.text = movieResult?.originalTitle
        rateMovieLabel.text = "⭐ \(String(describing: movieResult?.voteAverage))"
        overviewDescriptionLabel.text = movieResult?.overview
        
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
