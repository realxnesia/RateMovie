//
//  TTGSnackBarManager.swift
//  RateMovie
//
//  Created by realxnesia on 02/08/23.
//

import Foundation
import UIKit
import TTGSnackbar

public struct WrapperTTGSnackBar {
    let snackbar: TTGSnackbar
    
    func start() -> TTGSnackbar {
        return snackbar
    }
}
protocol AccessibleTTGSnackBarInterface {
    func createSnackBar(
        message: String,
        duration: TTGSnackbarDuration
    ) -> WrapperTTGSnackBar
}

public final class AccessibleTTGSnackBar: AccessibleTTGSnackBarInterface {
    public func createSnackBar(
        message: String,
        duration: TTGSnackbarDuration = .middle
    ) -> WrapperTTGSnackBar {
        let snackbar = TTGSnackbar(message: message, duration: duration)
        snackbar.backgroundColor = hexStringToUIColor(hex: "#DCF8E7")
        snackbar.layer.borderColor = hexStringToUIColor(hex: "#219155").cgColor
        snackbar.layer.borderWidth = 1
        snackbar.messageTextColor = hexStringToUIColor(hex: "#219155")
        snackbar.actionTextNumberOfLines = 0
        snackbar.shouldDismissOnSwipe = true
        snackbar.show()
        return WrapperTTGSnackBar(snackbar: snackbar)
    }
}
