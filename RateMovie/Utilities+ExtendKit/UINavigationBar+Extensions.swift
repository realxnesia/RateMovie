//
//  UINavigationBar+Extensions.swift
//  RateMovie
//
//  Created by realxnesia on 30/07/23.
//

import Foundation
import UIKit

extension UINavigationBar {
    func setGradientBackgroundDefault() {
        var updatedFrame = bounds
        updatedFrame.size.height += 40
        
        let color1 = hexStringToUIColor(hex: "#184DAB")
        let color2 = hexStringToUIColor(hex: "#184DAB")
        let colors = [color1, color2 ]
        let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: colors)
        
        setBackgroundImage(gradientLayer.createGradientImage(), for: UIBarMetrics.default)
    }
    
    func shouldRemoveShadow(_ value: Bool) -> Void {
        if value {
            self.setValue(true, forKey: "hidesShadow")
        } else {
            self.setValue(false, forKey: "hidesShadow")
        }
    }
}
