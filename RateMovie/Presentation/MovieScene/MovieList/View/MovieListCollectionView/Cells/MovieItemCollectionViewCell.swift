//
//  MovieItemCollectionViewCell.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 06/10/22.
//

import UIKit

class MovieItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var moviePreviewImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRateLabel: UILabel!
    @IBOutlet weak var movieLanguageLabel: UILabel!
    
    static let identifier = "MovieItemCollectionViewCell"
    static func nib() -> UINib {
        UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        moviePreviewImageView.contentMode = .scaleAspectFit
    }

}
