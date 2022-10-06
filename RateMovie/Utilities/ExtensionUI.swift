//
//  ExtensionUI.swift
//  RateMovie
//
//  Created by DHIKA ADITYA ARE on 06/10/22.
//

import Foundation
import UIKit
import SwiftUI
import TTGSnackbar

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

extension CAGradientLayer {
    convenience init(frame: CGRect, colors: [UIColor]) {
        self.init()
        self.frame = frame
        self.colors = []
        for color in colors {
            self.colors?.append(color.cgColor)
        }
        startPoint = CGPoint(x: 0, y: 0)
        endPoint = CGPoint(x: 1, y: 0)
    }
    
    func createGradientImage() -> UIImage? {
        
        var image: UIImage? = nil
        UIGraphicsBeginImageContext(bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return image
    }
    
//    class func primaryGradient(on view: UIView) -> UIImage? {
//        let gradient = CAGradientLayer()
//        let flareRed = UIColor(displayP3Red: 241.0/255.0, green: 39.0/255.0, blue: 17.0/255.0, alpha: 1.0)
//        let flareOrange = UIColor(displayP3Red: 245.0/255.0, green: 175.0/255.0, blue: 25.0/255.0, alpha: 1.0)
//        var bounds = view.bounds
//        bounds.size.height += UIApplication.shared.statusBarFrame.size.height
//        gradient.frame = bounds
//        gradient.colors = [flareRed.cgColor, flareOrange.cgColor]
//        gradient.startPoint = CGPoint(x: 0, y: 0)
//        gradient.endPoint = CGPoint(x: 1, y: 0)
//        return gradient.createGradientImage(on: view)
//    }
    
    private func createGradientImage(on view: UIView) -> UIImage? {
        var gradientImage: UIImage?
        UIGraphicsBeginImageContext(view.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
    
}
extension UITableView {
    func setEmptyTableView(message: String, messageImage: UIImage,btnHide: Bool, buttonTapAction1: @escaping () -> Void, buttonTapAction2: @escaping () -> Void ) {
        
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        emptyView.backgroundColor = .white
        let messageImageView = UIImageView()
        let messageLabel = UILabel()
        let backtoHome = UIButton()
        let backtoSearch = UIButton()
        
        messageImageView.backgroundColor = .clear
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageImageView.translatesAutoresizingMaskIntoConstraints = false
        backtoHome.translatesAutoresizingMaskIntoConstraints = false
        backtoSearch.translatesAutoresizingMaskIntoConstraints = false
        
        messageImageView.contentMode = .scaleAspectFit
        
        messageLabel.textColor = hexStringToUIColor(hex: "#486784")
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 12)
        messageLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        
        backtoHome.setTitle("Kembali ke Beranda", for: .normal)
        backtoHome.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        backtoHome.setTitleColor(.white, for: .normal)
        backtoHome.layer.backgroundColor = hexStringToUIColor(hex: "#D25C3F").cgColor
        backtoHome.layer.cornerRadius = 20
        backtoHome.layer.borderColor = hexStringToUIColor(hex: "#D25C3F").cgColor
        buttonActionSearchfirst = buttonTapAction1
        backtoHome.addTarget(self, action: #selector(pressed1(_:)), for: .touchUpInside)
        
        backtoSearch.setTitle("Coba Kata kunci Lain", for: .normal)
        backtoSearch.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        backtoSearch.setTitleColor(hexStringToUIColor(hex: "#D25C3F"), for: .normal)
        backtoSearch.layer.backgroundColor = UIColor.white.cgColor
        backtoSearch.layer.cornerRadius = 20
        backtoSearch.layer.borderColor = hexStringToUIColor(hex: "#D25C3F").cgColor
        backtoSearch.layer.borderWidth = 1
        buttonActionSearchsecond  = buttonTapAction2
        backtoSearch.addTarget(self, action: #selector(pressed2(_:)), for: .touchUpInside)
        
        emptyView.addSubview(messageLabel)
        emptyView.addSubview(messageImageView)
        emptyView.addSubview(backtoHome)
        emptyView.addSubview(backtoSearch)
        
        messageImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageImageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -80).isActive = true
        messageImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        messageImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: messageImageView.bottomAnchor, constant: 2).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.widthAnchor.constraint(equalToConstant: 220).isActive = true
        messageLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        backtoHome.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 8).isActive = true
        backtoHome.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        backtoHome.widthAnchor.constraint(equalToConstant: 170).isActive = true
        backtoHome.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        backtoSearch.topAnchor.constraint(equalTo: backtoHome.bottomAnchor, constant: 8).isActive = true
        backtoSearch.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        backtoSearch.widthAnchor.constraint(equalToConstant: 170).isActive = true
        backtoSearch.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        messageImageView.image = messageImage
        messageLabel.text = message
        backtoHome.isHidden = btnHide
        backtoSearch.isHidden = btnHide
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
            
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    @objc func pressed1(_ sender: UIButton) {
       guard let action = buttonActionSearchfirst else {
           print("tidak ada aksi")
           return
       }
       action()
     }
    @objc func pressed2(_ sender: UIButton) {
       guard let action = buttonActionSearchsecond else {
           print("tidak ada aksi")
           return
       }
       action()
     }
    
}
var buttonActionSearchfirst: (() -> Void)?
var buttonActionSearchsecond: (() -> Void)?

extension UIViewController{
    func gotoRootViewController(){
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let firstWindow = firstScene.windows.first else { return }

        let rootController = TabBarController()
        let snapshot = firstWindow.snapshotView(afterScreenUpdates: true)!
        rootController.view.addSubview(snapshot)

        firstWindow.rootViewController = rootController

        UIView.transition(with: snapshot,
                          duration: 0.3,
                          options: .curveEaseInOut,
                          animations: {
            snapshot.layer.opacity = 0
        },
                          completion: { status in
            snapshot.removeFromSuperview()
        })
        firstWindow.makeKeyAndVisible()
        
    }
    
    func gotoHistoryListTransactionViewController(){
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let firstWindow = firstScene.windows.first else { return }
        
        let rootController = RootViewController(rootViewController: MovieListViewController())
        let snapshot = firstWindow.snapshotView(afterScreenUpdates: true)!
        rootController.view.addSubview(snapshot)
        
        firstWindow.rootViewController = rootController
        
        UIView.transition(with: snapshot,
                          duration: 0.3,
                          options: .curveEaseInOut,
                          animations: {
            snapshot.layer.opacity = 0
        },
                          completion: { status in
            snapshot.removeFromSuperview()
        })
        firstWindow.makeKeyAndVisible()
        
    }
    
    func snakeBar(message: String, duration: TTGSnackbarDuration = .middle, backgroundColor: UIColor? = hexStringToUIColor(hex: "#FFE4E4"), borderColor: UIColor? = hexStringToUIColor(hex: "#B44242"), textColor: UIColor? = hexStringToUIColor(hex: "#B44242")){
        let snackbar = TTGSnackbar(message: message, duration: duration)
        snackbar.backgroundColor = backgroundColor
        snackbar.layer.borderColor = borderColor?.cgColor
        snackbar.layer.borderWidth = 1
        snackbar.messageTextColor = textColor!
        snackbar.actionTextNumberOfLines = 0
        snackbar.show()
        snackbar.shouldDismissOnSwipe = true
        
    }
    
    func snakeBarGreen(message: String, duration: TTGSnackbarDuration = .middle, backgroundColor: UIColor? = hexStringToUIColor(hex: "#DCF8E7"), borderColor: UIColor? = hexStringToUIColor(hex: "#219155"), textColor: UIColor? = hexStringToUIColor(hex: "#219155")){
        let snackbar = TTGSnackbar(message: message, duration: duration)
        snackbar.backgroundColor = backgroundColor
        snackbar.layer.borderColor = borderColor?.cgColor
        snackbar.layer.borderWidth = 1
        snackbar.messageTextColor = textColor!
        snackbar.actionTextNumberOfLines = 0
        snackbar.show()
        snackbar.shouldDismissOnSwipe = true
        
    }
    
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func convertPhoneNumberFormat(currNumber: String) -> (String, Bool){
        var newPhoneNumb: String = ""
        if String(currNumber.prefix(2)) == "62"{
            let tempPhoneNumb = String(currNumber.suffix(currNumber.count - 2))
            print("ini no telp: \(tempPhoneNumb)")
            newPhoneNumb = "+62\(tempPhoneNumb)"
            return (newPhoneNumb, true)
            
        }else if String(currNumber.prefix(2)) == "08"{
            let tempPhoneNumb = String(currNumber.suffix(currNumber.count - 2))
            print("ini no telp: \(tempPhoneNumb)")
            newPhoneNumb = "+628\(tempPhoneNumb)"
            return (newPhoneNumb, true)
            
        }else if String(currNumber.prefix(3)) == "+62"{
            newPhoneNumb = currNumber
            return (newPhoneNumb, true)
        }else{
           return (currNumber, false)
        }
    }
    
//    func convert24Hours(time: String) -> String {
//        return String(time.prefix(4))
//    }
    
    func changeTimeToWIB(start: String, end: String) -> String {
        let startTime = start.prefix(5)
        let endTime = end.prefix(5)
        if start == "" {
            return "\(String(describing: endTime)) WIB"
        } else if end == "" {
            return "\(String(describing: startTime)) WIB"
        } else {
            return "\(String(describing: startTime)) - \(String(describing: endTime)) WIB"
        }
    }
    
    func getIntFromString(with value: String) -> String {
        var flag: String?
        let stringArray = value.components(separatedBy: .decimalDigits.inverted)
        for item in stringArray {
            if let number = Int(item) {
                flag = "\(number)"
            }
        }
        return flag ?? "nil"
    }

    func changeDateToDayMonthYear(with date: String) -> String {
//        Locale(identifier: "id_ID")
        
        let date = date.prefix(10)
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "YYYY-MM-dd"
        inputFormatter.locale = Locale(identifier: "id_ID")
        
        let outputDayFormatter = DateFormatter()
        outputDayFormatter.dateFormat = "EEE"

        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "dd"
        
        let outputMonthFormatter = DateFormatter()
        outputMonthFormatter.dateFormat = "MMMM"
        outputMonthFormatter.locale = Locale(identifier: "id_ID")
        
        let outputYearFormatter = DateFormatter()
        outputYearFormatter.dateFormat = "YYYY"

        let showDate = inputFormatter.date(from: String(date))
//        let resultDayString = outputDayFormatter.string(from: showDate!)
        let resultDateString = outputDateFormatter.string(from: showDate!)
        let resultMonthString = outputMonthFormatter.string(from: showDate!)
        let resultYearString = outputYearFormatter.string(from: showDate!)
        
        return resultDateString + " " + resultMonthString + " " + resultYearString
        
//        dateDayLabel.text = resultDateString
//        dateMonthLabel.text = "\(resultMonthString), \(resultDayString) "
//        dateYearLabel.text = resultYearString
    }
    
    func alertRequestAuthorization(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        present(alert, animated: true)
        alert.addAction(UIAlertAction(title: "Open Access", style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString){
                if #available(iOS 10.0, *){
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    }
    
}

extension UIApplication {
    class var statusBarBackgroundColor: UIColor? {
        get {
            return (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor
        } set {
            (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor = newValue
        }
    }
}

extension Int {
    func secondsToMinutesSeconds() -> String {
        let (m,s) = ((self % 3600) / 60, (self % 3600) % 60)
        let m_string =  m < 10 ? "0\(m)" : "\(m)"
        let s_string =  s < 10 ? "0\(s)" : "\(s)"

        return "\(m_string):\(s_string)"
    }
}

extension UIView{
    func applyShadow(cornerRadius: CGFloat){
        layer.cornerRadius = cornersRadius
        layer.masksToBounds = false
        layer.shadowRadius = 20.0
        layer.shadowOpacity = 0.30
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
}



func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
