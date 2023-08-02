//
//  UIView+Extensions.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 06/10/22.
//

import Foundation
import UIKit

extension UIView {
  
  // A method to get all subviews with spesific type.
  func allSubViewsOf<T : UIView>(type : T.Type) -> [T]{
    var all = [T]()
    func getSubview(view: UIView) {
      if let aView = view as? T{
        all.append(aView)
      }
      guard view.subviews.count>0 else { return }
      view.subviews.forEach{ getSubview(view: $0) }
    }
    getSubview(view: self)
    return all
  }
  
  // A property to set a view into a circle
  @IBInspectable
  var circleRadius: Bool {
    get { return false }
    set {
      if newValue == true {
        let radius = self.frame.width / 2
        layer.cornerRadius = radius
        
      }
    }
  }

  // A property to set view's corner radius
  @IBInspectable
  var cornersRadius: CGFloat {
    get { return 0 }
    set {
      layer.cornerRadius = newValue
    }
  }
  
  public func createShadow() {
    self.layer.shadowColor = UIColor.gray.cgColor
    self.layer.shadowOpacity = 0.5
    self.layer.shadowOffset = CGSize(width: 0, height: 0.5)
  }
  
  func addBorder(to edges: UIRectEdge, color: UIColor = UIColor.white, thickness: CGFloat = 1) {
    
    var borders = [UIView]()
    
    func border() -> UIView {
      let border = UIView(frame: CGRect.zero)
      border.backgroundColor = color
      border.translatesAutoresizingMaskIntoConstraints = false
      return border
    }
    
    if edges.contains(.top) || edges.contains(.all) {
      let top = border()
      addSubview(top)
      addConstraints(
        NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[top(==thickness)]",
                                       options: [],
                                       metrics: ["thickness": thickness],
                                       views: ["top": top]))
      addConstraints(
        NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[top]-(0)-|",
                                       options: [],
                                       metrics: nil,
                                       views: ["top": top]))
      borders.append(top)
    }
    
    if edges.contains(.left) || edges.contains(.all) {
      let left = border()
      addSubview(left)
      addConstraints(
        NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[left(==thickness)]",
                                       options: [],
                                       metrics: ["thickness": thickness],
                                       views: ["left": left]))
      addConstraints(
        NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[left]-(0)-|",
                                       options: [],
                                       metrics: nil,
                                       views: ["left": left]))
      borders.append(left)
    }
    
    if edges.contains(.right) || edges.contains(.all) {
      let right = border()
      addSubview(right)
      addConstraints(
        NSLayoutConstraint.constraints(withVisualFormat: "H:[right(==thickness)]-(0)-|",
                                       options: [],
                                       metrics: ["thickness": thickness],
                                       views: ["right": right]))
      addConstraints(
        NSLayoutConstraint.constraints(withVisualFormat: "V:|-(15)-[right]-(15)-|",
                                       options: [],
                                       metrics: nil,
                                       views: ["right": right]))
      borders.append(right)
    }
    
    if edges.contains(.bottom) || edges.contains(.all) {
      let bottom = border()
      addSubview(bottom)
      addConstraints(
        NSLayoutConstraint.constraints(withVisualFormat: "V:[bottom(==thickness)]-(0)-|",
                                       options: [],
                                       metrics: ["thickness": thickness],
                                       views: ["bottom": bottom]))
      addConstraints(
        NSLayoutConstraint.constraints(withVisualFormat: "H:|-(15)-[bottom]-(15)-|",
                                       options: [],
                                       metrics: nil,
                                       views: ["bottom": bottom]))
      borders.append(bottom)
    }
    
  }

  public func getAllParticularView<T: UIView>(of view: T.Type) -> [T] {
    let views = self.allSubViewsOf(type: view)
    return views
  }
    
}

enum GradientDirection {
    case leftToRight
    case rightToLeft
    case topToBottom
    case bottomToTop
}

extension UIView {
    func gradientBackground(from color1: UIColor, to color2: UIColor, direction: GradientDirection) {
        let gradient = CAGradientLayer()
        var updatedFrame = self.bounds
        updatedFrame.size.width += 40
        gradient.frame = updatedFrame
        gradient.colors = [color1.cgColor, color2.cgColor]

        switch direction {
        case .leftToRight:
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        case .rightToLeft:
            gradient.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 0.0, y: 0.5)
        case .bottomToTop:
            gradient.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradient.endPoint = CGPoint(x: 0.5, y: 0)
        default:
            break
        }

        self.layer.insertSublayer(gradient, at: 0)
    }
}

extension UIView {
    func setCornerRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
        
        if self is UITextField {
            setBorder(width: 1)
        }
    }
    
    func setBorder(width: CGFloat, color: UIColor = UIColor.black) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    func applyShadow(cornerRadius: CGFloat){
        layer.cornerRadius = cornersRadius
        layer.masksToBounds = false
        layer.shadowRadius = 20.0
        layer.shadowOpacity = 0.30
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
}

