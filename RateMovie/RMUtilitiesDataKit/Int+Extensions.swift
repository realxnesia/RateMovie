//
//  Int+Extensions.swift
//  RateMovie
//
//  Created by realxnesia on 30/07/23.
//

import Foundation
import UIKit

extension Int {
    func secondsToMinutesSeconds() -> String {
        let (m,s) = ((self % 3600) / 60, (self % 3600) % 60)
        let m_string =  m < 10 ? "0\(m)" : "\(m)"
        let s_string =  s < 10 ? "0\(s)" : "\(s)"

        return "\(m_string):\(s_string)"
    }
}
