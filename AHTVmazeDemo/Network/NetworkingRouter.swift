//
//  NetworkingRouter.swift
//  AHTVmazeDemo
//
//  Created by Andreas Hörberg on 2019-04-11.
//  Copyright © 2019 Andreas Hörberg. All rights reserved.
//

import Foundation

protocol NetworkingRouter {
    var baseURL: URL { get }
    var path: String { get }
    var urlRequest: URLRequest { get }
    var httpMethod: HTTPMethod { get }
    var parameters: [String: Any]? { get }
}

enum HTTPMethod: String {
    // Add more methods as needed
    case get = "GET"
}

extension NetworkingRouter {
    var baseURL: URL { return NetworkingServer.baseURL }
    var urlRequest: URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        if let components = urlComponents(with: parameters, for: url) {
            request.url = components.url
        }
        return request
    }
    
    func urlComponents(with parameters: [String: Any]?, for url: URL) -> URLComponents? {
        guard let parameters = parameters else { return nil }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems: [URLQueryItem] = parameters.compactMap({ URLQueryItem(name: $0.key, value: "\($0.value)") })
        components?.queryItems = queryItems
        return components
    }
}
