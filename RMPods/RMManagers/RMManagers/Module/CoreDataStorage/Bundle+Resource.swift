//
//  Bundle+Resource.swift
//  Alamofire
//
//  Created by realxnesia on 04/08/23.
//

import Foundation

extension Bundle {
    var resource: Bundle {
       // static framework
       if let resourceURL = resourceURL,
           let resourceBundle = Bundle(url: resourceURL.appendingPathComponent(ModuleName.name + ".bundle")) {
           return resourceBundle
       } else {
       // dynamic framework
           return self
       }
    }
}

private struct ModuleName {
   static var name: String = {
       String(reflecting: ModuleName.self).components(separatedBy: ".").first ?? ""
   }()
}
