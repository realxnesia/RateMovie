//
//  RootViewController.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 06/10/22.
//

import Foundation
import UIKit

enum BackgroundColorType: String {
  case white = "navigationBackgroundWhite"
  case orange = "navigationBackground"
}

class RootViewController: UINavigationController {
  // MARK: - Lifecycle
  private let currentVersion = (UIDevice.current.systemVersion as NSString).floatValue
  override func viewDidLoad() {
    super.viewDidLoad()
    self.edgesForExtendedLayout = .all
    self.extendedLayoutIncludesOpaqueBars = false
    self.navigationBar.isOpaque = false
    setNavigationBar()
  }
    
  private func setNavigationBar() {
    
    if #available(iOS 13.0, *) {
      let appearance = UINavigationBarAppearance()
      appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .orange
      appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
      appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
      navigationBar.compactAppearance = appearance
      navigationBar.standardAppearance = appearance
      navigationBar.scrollEdgeAppearance = appearance
    }
    navigationItem.hideBackButtonTitle = true
    navigationBarIsTranslucent(false)
    setBackgroundImageToNil()
  }
  
  // Configuration for iOS 12.x
  public func setBackgroundImageToNil() {
    if self.currentVersion <= 12.9 {
      navigationBar.setBackgroundImage(UIImage(), for: .default)
      navigationBar.shadowImage = UIImage()
      navigationBar.shouldRemoveShadow(true)
    }
  }
  
  public func setNavigationBarForOldDevices() {
    self.navigationBarIsTranslucent(false)
    self.setBackgroundImageToNil()
  }
  
  public func setBackgroundWithImage(backgroundColor: BackgroundColorType = .orange) {
    if self.currentVersion <= 12.9 {
      navigationBar.shadowImage = UIImage(named: backgroundColor.rawValue)?.withRenderingMode(.alwaysOriginal)
      navigationBar.setBackgroundImage(UIImage(named: backgroundColor.rawValue)?.withRenderingMode(.alwaysOriginal), for: .default)
    }
  }
  
  public func navigationBarIsTranslucent(_ bool: Bool) {
    if self.currentVersion <= 12.9 {
      navigationBar.isTranslucent = bool
      navigationBar.isOpaque = true
    }
  }
  
    public func setBackgroundColor(with color: UIColor? = .orange, titleColor: UIColor? = .white) {
    if #available(iOS 13.0, *) {
      navigationBar.compactAppearance?.backgroundColor = color
      navigationBar.scrollEdgeAppearance?.backgroundColor = color
      navigationBar.standardAppearance.backgroundColor = color
      navigationBar.compactAppearance?.titleTextAttributes = [.foregroundColor: titleColor!]
      navigationBar.scrollEdgeAppearance?.titleTextAttributes = [.foregroundColor: titleColor!]
      navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: titleColor!]
    } else if self.currentVersion <= 12.9 {
      self.setBackgroundWithImage()
      navigationBar.shouldRemoveShadow(true)
    }
    
  }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        if let topVC = viewControllers.last {
            return topVC.preferredStatusBarStyle
        }
        return .default
    }
}

extension UINavigationItem {
  
  var hideBackButtonTitle: Bool {
    get { return false }
    set {
      if newValue == true {
        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backBarButton.setTitleTextAttributes([.foregroundColor: UIColor.clear], for: .normal)
        backBarButton.setTitleTextAttributes([.foregroundColor: UIColor.clear], for: .highlighted)
        backBarButtonItem = backBarButton
      }
    }
  }
}

protocol WhiteNavBar {}
extension WhiteNavBar where Self: UIViewController {

  
  func setNavigationBackground() {
    if let nav = navigationController as? RootViewController {
        nav.setBackgroundColor(with: .white, titleColor: .orange)
      nav.setBackgroundWithImage(backgroundColor: .white)
      nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.orange]
        nav.navigationBar.layer.shadowColor = UIColor.gray.cgColor
      nav.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
      nav.navigationBar.layer.shadowRadius = 0.5
      nav.navigationBar.layer.shadowOpacity = 1.0
    }
  }
  
  func resetNavigationBackground() {
    if let nav = navigationController as? RootViewController {
        nav.setBackgroundColor(with: .orange, titleColor: .white)
      nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
      nav.navigationBar.layer.shadowColor = UIColor.clear.cgColor
    }
  }
}

protocol RedNavBar{}
extension RedNavBar where Self: UIViewController {

    func setNavigationBackground() {
      if let nav = navigationController as? RootViewController {
          nav.setBackgroundColor(with: hexStringToUIColor(hex: "831010"), titleColor: .white)
          nav.setBackgroundWithImage(backgroundColor: .white)
        nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black ]
          nav.navigationBar.layer.shadowColor = UIColor.gray.cgColor
          nav.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
          nav.navigationBar.layer.shadowRadius = 0.5
          nav.navigationBar.layer.shadowOpacity = 1.0
      }
    }
    
    func resetNavigationBackground() {
        if let nav = navigationController as? RootViewController {
            nav.setBackgroundColor(with: .red, titleColor: .white)
            nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            nav.navigationBar.layer.shadowColor = UIColor.clear.cgColor
        }
    }
}

protocol ClearNavBar{}
extension ClearNavBar where Self: UIViewController {
    func setNavigationBackground() {
      if let nav = navigationController as? RootViewController {
          nav.setBackgroundColor(with: .clear)
          nav.setBackgroundImageToNil()
          nav.navigationBarIsTranslucent(true)
          
          nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
          nav.navigationBar.layer.shadowColor = UIColor.gray.cgColor
          nav.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
          nav.navigationBar.layer.shadowRadius = 0.5
          nav.navigationBar.layer.shadowOpacity = 1.0
      }

    }
    
    func resetNavigationBackground() {
        if let nav = navigationController as? RootViewController {
            nav.setBackgroundColor(with: .orange, titleColor: .white)
            nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            nav.navigationBar.layer.shadowColor = UIColor.clear.cgColor
            
            nav.setBackgroundColor()
            nav.navigationBarIsTranslucent(false)
            nav.setBackgroundWithImage()
        }
    }
    
}

protocol ShadowNavBar{}
extension ShadowNavBar where Self: UIViewController {
    
    func setNavigationBackground() {
      if let nav = navigationController as? RootViewController {
          nav.navigationBar.shadowImage = UIImage()
          nav.navigationBar.isTranslucent = true
          nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
          
          nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black ?? .black]
          nav.navigationBar.layer.shadowColor = UIColor.gray.cgColor
          nav.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
          nav.navigationBar.layer.shadowRadius = 0.5
          nav.navigationBar.layer.shadowOpacity = 1.0
      }
//        setLightStatusBar()

    }
    
    func resetNavigationBackground() {
        if let nav = navigationController as? RootViewController {
            nav.setBackgroundColor(with: .orange, titleColor: .white)
            nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            nav.navigationBar.layer.shadowColor = UIColor.clear.cgColor
            
            nav.setBackgroundColor()
            nav.navigationBarIsTranslucent(false)
            nav.setBackgroundWithImage()
        }
    }
    
}

