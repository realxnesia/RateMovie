//
//  MovieListViewController.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 06/10/22.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint! //collection harusnya yg punya height bukan viewnya.
    
    
}

extension MovieListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        collectionViewHeight.constant = collectionView.contentSize.height
        collectionViewHeight.constant = UIScreen.main.bounds.height
    }
}

extension MovieListViewController {
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(MovieItemCollectionViewCell.nib(), forCellWithReuseIdentifier: MovieItemCollectionViewCell.identifier)
    }
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieItemCollectionViewCell.identifier, for: indexPath) as? MovieItemCollectionViewCell
        else {
            return UICollectionViewCell()
        }

        
        return movieCell
    }
    
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
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
