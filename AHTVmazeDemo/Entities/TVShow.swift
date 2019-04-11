//
//  TVShow.swift
//  AHTVmazeDemo
//
//  Created by Andreas Hörberg on 2019-04-11.
//  Copyright © 2019 Andreas Hörberg. All rights reserved.
//

import Foundation

struct TVShow: Decodable {
    let id: Int?
    let name: String
    let type: String
    let language: String
    let genres: [String]
    let status: String
    let premiered: String
    let rating: Rating
    let image: ImageReference
}

struct Rating: Decodable, Equatable {
    let average: Double?
}

struct ImageReference: Decodable, Equatable {
    private let medium: String
    private let original: String
    var mediumURL: URL? { return URL(string: medium) }
    var originalURL: URL? { return URL(string: original) }
}
