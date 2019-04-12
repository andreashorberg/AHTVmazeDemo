//
//  NetworkingProvider.swift
//  AHTVmazeDemo
//
//  Created by Andreas Hörberg on 2019-04-11.
//  Copyright © 2019 Andreas Hörberg. All rights reserved.
//

import Foundation

class NetworkingProvider {
    let router: NetworkingRouter
    let session = URLSession.shared
    
    init(router: NetworkingRouter) {
        self.router = router
    }
    
    func send(completion: @escaping (Result<[[String: Any]], NetworkingError>) -> Void) {
        requestStarted()
        let task = session.dataTask(with: router.urlRequest) { data, response, error in
            self.requestFinished()
            switch (data, response, error) {
            case (_, _, .some(_)):
                // Parse error into proper type here
                completion(.failure(.badRequest))
            case (.some(let data), .some(let response as HTTPURLResponse), _):
                // Handle more status codes here as needed like empty or invalid authentication
                guard response.statusCode == 200 else { completion(.failure(.badRequest)); return }
                guard let json = self.parseJSON(data: data) else { completion(.failure(.failedParsing)); return }
                completion(.success(json))
            default:
                completion(.failure(.badRequest))
            }
        }
        task.resume()
    }
    
    func parseJSON(data: Data) -> [[String: Any]]? {
        return try? JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [[String: Any]]
    }
    
    func requestStarted() {
        
    }
    
    func requestFinished() {
        
    }
}
