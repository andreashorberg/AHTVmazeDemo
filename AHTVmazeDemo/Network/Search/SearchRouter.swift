//
//  SearchRouter.swift
//  AHTVmazeDemo
//
//  Created by Andreas Hörberg on 2019-04-11.
//  Copyright © 2019 Andreas Hörberg. All rights reserved.
//

import Foundation

enum SearchRouter: NetworkingRouter {
    case showSearch(request: ShowSearchRequest)
    
    var path: String {
        switch self {
        case .showSearch(request: _):
            return "/search/shows"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .showSearch(_):
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .showSearch(let request):
            return request.asDictionary()
        }
    }
}
