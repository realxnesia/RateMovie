//
//  MovieItemCollectionViewCell.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 06/10/22.
//

import UIKit

class MovieItemCollectionViewCell: UICollectionViewCell {

    static let identifier = "MovieItemCollectionViewCell"
    static func nib() -> UINib {
        UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
