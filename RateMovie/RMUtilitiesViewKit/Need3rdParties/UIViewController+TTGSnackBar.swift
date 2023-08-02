//
//  UIViewController+TTGSnackBar.swift
//  RateMovie
//
//  Created by realxnesia on 30/07/23.
//

import Foundation
import UIKit
// import TTGSnackbar // soon we import module

// MARK: - TTGSnackbar
extension UIViewController {
    var accessibleSnackBar: AccessibleTTGSnackBarInterface {
        return AccessibleTTGSnackBar()
    }

    func snakeBar(
        message: String
    ) -> UIView {
        let accessible = accessibleSnackBar.createSnackBar(message: message, duration: .middle)
        return accessible.start()
    }
}
