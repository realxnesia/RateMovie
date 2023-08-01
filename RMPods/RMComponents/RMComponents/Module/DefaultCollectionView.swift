//
//  DefaultCollectionView.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 07/10/22.
//

import Foundation
import UIKit

public class DefaultCollectionView: UICollectionView {
    
    public var isBouncesVertical: Bool = false
    public var touchCallback: (() -> Void)?
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.touchCallback?()
    }
    
    public override var intrinsicContentSize: CGSize {
        return contentSize
    }
    
    public override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    override init(frame: CGRect, collectionViewLayout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        self.alwaysBounceVertical = isBouncesVertical
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
