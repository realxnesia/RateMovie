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
    
    //TODO: Parsing Data
    var movieResult: MovieNowPlayingResponse.Result?
    var viewModel: MovieDetailsViewModel?
}

//MARK: - View Lifecycle
extension MovieDetailsViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBackground()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setupView()
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        recommendationCollectionViewHeight.constant = recommendationCollectionView.contentSize.height
//        recommendationCollectionViewHeight.constant = recommendationCollectionView.collectionViewLayout.collectionViewContentSize.height
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        resetNavigationBackground()
    }
}

//MARK: Configuration Method
extension MovieDetailsViewController {
    private func configureCollectionView() {
        recommendationCollectionView.delegate = self
        recommendationCollectionView.dataSource = self
        recommendationCollectionView.register(MovieItemCollectionViewCell.nib(), forCellWithReuseIdentifier: MovieItemCollectionViewCell.identifier)
    }
    
    private func setupView() {
        headerImageView.contentMode = .scaleAspectFit
        if let url = movieResult?.backdropPath, let imageUrl = URL(string: Endpoint.Images.baseImage + url) {
            headerImageView.kf.setImage(with: imageUrl, placeholder: UIImage.init(named: ""), options: [.transition(.fade(0))], progressBlock: nil, completionHandler: nil)
        }
        
        if let url = movieResult?.posterPath, let imageUrl = URL(string: Endpoint.Images.baseImage + url) {
            contentImageView.kf.setImage(with: imageUrl, placeholder: UIImage.init(named: ""), options: [.transition(.fade(0))], progressBlock: nil, completionHandler: nil)
        }
        
        titleMovieLabel.text = movieResult?.originalTitle
        if let rateMovie = movieResult?.voteAverage {
            rateMovieLabel.text = "⭐" + String(rateMovie)
        }
//        rateMovieLabel.text = "⭐ \(String(describing: movieResult?.voteAverage))"
        overviewDescriptionLabel.text = movieResult?.overview
    }
    
    private func bind() {
        viewModel?.movieSimilar.observe(on: self) { [weak self] movieSimilar in
            self?.recommendationCollectionView.reloadData()
            if movieSimilar.count != 0 {
                self?.recommendationCollectionView.reloadData()
//                self?.recommendationCollectionViewHeight.constant = (self?.recommendationCollectionView.collectionViewLayout.collectionViewContentSize.height)!
                self?.recommendationCollectionView.invalidateIntrinsicContentSize()
                self?.recommendationCollectionView.setNeedsLayout()
                self?.recommendationCollectionView.layoutIfNeeded()
            }
        }
    }
}

//MARK: - Collection View
extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.movieSimilar.value.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let movieItem = collectionView.dequeueReusableCell(withReuseIdentifier: MovieItemCollectionViewCell.identifier, for: indexPath) as? MovieItemCollectionViewCell,
           let data = viewModel?.movieSimilar.value[indexPath.row],
           let voteAverage = data.voteAverage {

            movieItem.movieTitleLabel.text = data.originalTitle
            
            movieItem.movieRateLabel.text = "⭐ \(String(describing: voteAverage))"
            movieItem.movieLanguageLabel.text = data.originalLanguage
            if let url = data.posterPath, let imageUrl = URL(string: Endpoint.Images.baseImage + url) {
                movieItem.moviePreviewImageView.kf.setImage(with: imageUrl, placeholder: UIImage.init(named: ""), options: [.transition(.fade(0))], progressBlock: nil, completionHandler: nil)
            }
            
            return movieItem
        }
        return UICollectionViewCell()
    }
    
}

//MARK: - Collection Flow Layout
extension MovieDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let height = collectionView.frame.size.height
        let width = collectionView.frame.size.width
        let twoColumnCellWidth = (width - 40) / 3
//        recommendationCollectionViewHeight.constant = screenSize.height/3 - 16
//        return CGSize(width: screenSize.width/3 - 16, height: screenSize.height/2 - 20)
        return CGSize(width: twoColumnCellWidth, height: height)
//        return CGSize(width: 400, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}
