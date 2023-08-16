//
//  MovieDetailsViewController.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 07/10/22.
//

import UIKit
import Kingfisher
import RMComponents
import RMDomainEntities
import RMNetworking

class MovieDetailsViewController: UIViewController, ClearNavBar {
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var rateMovieLabel: UILabel!
    @IBOutlet weak var categoryAdultLabel: UILabel!
    
    @IBOutlet weak var overviewDescriptionLabel: UILabel!
    @IBOutlet weak var recommendationCollectionView: UICollectionView!
    @IBOutlet weak var recommendationCollectionViewHeight: NSLayoutConstraint!
    
    var viewModel: MovieDetailsViewModel?
}

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
        viewModel?.didLoad()
        configureCollectionView()
        setupView()
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
        recommendationCollectionView.register(
            MovieItemCollectionViewCell.nib(),
            forCellWithReuseIdentifier: MovieItemCollectionViewCell.identifier
        )
    }
    
    private func setupView() {
        headerImageView.contentMode = .scaleAspectFit
        if let url = viewModel?.getMovieResult().backdropPath,
           let imageUrl = URL(string: Endpoint.Images.baseImage + url)
        {
            headerImageView.kf.setImage(
                with: imageUrl,
                placeholder: UIImage.init(named: ""),
                options: [.transition(.fade(0))],
                progressBlock: nil,
                completionHandler: nil
            )
        }
        
        if let url = viewModel?.getMovieResult().posterPath,
            let imageUrl = URL(string: Endpoint.Images.baseImage + url) {
            contentImageView.kf.setImage(
                with: imageUrl,
                placeholder: UIImage.init(named: ""),
                options: [.transition(.fade(0))],
                progressBlock: nil,
                completionHandler: nil
            )
        }
        
        titleMovieLabel.text = viewModel?.getMovieResult().originalTitle
        rateMovieLabel.text = viewModel?.getMovieResult().formattedRating
        categoryAdultLabel.text = viewModel?.getMovieResult().formattedAdult
        overviewDescriptionLabel.text = viewModel?.getMovieResult().overview
    }
    
    private func bind() {
        viewModel?.movieSimilar.observe(on: self) { [weak self] movieSimilar in
            self?.recommendationCollectionView.reloadData()
            if movieSimilar.count != 0 {
                self?.recommendationCollectionView.reloadData()
                self?.recommendationCollectionView.invalidateIntrinsicContentSize()
                self?.recommendationCollectionView.setNeedsLayout()
                self?.recommendationCollectionView.layoutIfNeeded()
            }
        }
        viewModel?.isFavorite.observe(on: self, observerBlock: { _ in })
    }
}
