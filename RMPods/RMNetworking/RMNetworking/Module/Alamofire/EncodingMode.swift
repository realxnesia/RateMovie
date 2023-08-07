//
//  EncodingMode.swift
//  RMNetworking
//
//  Created by realxnesia on 07/08/23.
//

import Foundation
import Alamofire

// MARK: - Wrapper JSONEncoding Default
public struct EncodingMode: ParameterEncoding {
    public let jsonEncoding: JSONEncoding
    
    public init() {
        jsonEncoding = JSONEncoding.default
    }
    
    public func encode(
        _ urlRequest: URLRequestConvertible,
        with parameters: Parameters?
    ) throws -> URLRequest {
        return try jsonEncoding.encode(urlRequest, with: parameters)
    }
}

