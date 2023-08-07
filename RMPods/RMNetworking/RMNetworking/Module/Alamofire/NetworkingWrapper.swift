//
//  NetworkingWrapper.swift
//  RMNetworking
//
//  Created by realxnesia on 07/08/23.
//

import Foundation
import Alamofire

public struct NetworkingWrapper {
    public static func request<T: Codable>(
        url: URLConvertible,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        encoding: JSONEncoding,
        headers: HTTPHeaders,
        completionHandler: @escaping (Result<T, Error>) -> Void
    ) {
        AF.request(
            url,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers
        )
        .validate()
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case let .success(result):
                completionHandler(.success(result))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
}
