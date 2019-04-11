//
//  ShowSearchRequest.swift
//  AHTVmazeDemo
//
//  Created by Andreas Hörberg on 2019-04-11.
//  Copyright © 2019 Andreas Hörberg. All rights reserved.
//

import Foundation

struct ShowSearchRequest: Codable {
    var query: String
    
    private enum CodingKeys: String, CodingKey {
        case query = "q"
    }
}
