//
//  UIViewController+TTGSnackBar.swift
//  RateMovie
//
//  Created by realxnesia on 30/07/23.
//

import Foundation
import UIKit
import TTGSnackbar

// MARK: - TTGSnackbar
extension UIViewController {
    // TODO: Refactor Snackbar!
    func snakeBar(
        message: String,
        duration: TTGSnackbarDuration = .middle,
        backgroundColor: UIColor? = hexStringToUIColor(hex: "#FFE4E4"),
        borderColor: UIColor? = hexStringToUIColor(hex: "#B44242"),
        textColor: UIColor? = hexStringToUIColor(hex: "#B44242")
    ) {
        let snackbar = TTGSnackbar(message: message, duration: duration)
        snackbar.backgroundColor = backgroundColor
        snackbar.layer.borderColor = borderColor?.cgColor
        snackbar.layer.borderWidth = 1
        snackbar.messageTextColor = textColor!
        snackbar.actionTextNumberOfLines = 0
        snackbar.show()
        snackbar.shouldDismissOnSwipe = true
        
    }
    
    func snakeBarGreen(
        message: String,
        duration: TTGSnackbarDuration = .middle,
        backgroundColor: UIColor? = hexStringToUIColor(hex: "#DCF8E7"),
        borderColor: UIColor? = hexStringToUIColor(hex: "#219155"),
        textColor: UIColor? = hexStringToUIColor(hex: "#219155")) {
        let snackbar = TTGSnackbar(message: message, duration: duration)
        snackbar.backgroundColor = backgroundColor
        snackbar.layer.borderColor = borderColor?.cgColor
        snackbar.layer.borderWidth = 1
        snackbar.messageTextColor = textColor!
        snackbar.actionTextNumberOfLines = 0
        snackbar.show()
        snackbar.shouldDismissOnSwipe = true
    }
}
