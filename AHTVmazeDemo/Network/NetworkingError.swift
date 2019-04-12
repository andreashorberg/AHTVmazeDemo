//
//  NetworkingError.swift
//  AHTVmazeDemo
//
//  Created by Andreas Hörberg on 2019-04-11.
//  Copyright © 2019 Andreas Hörberg. All rights reserved.
//

import Foundation

enum NetworkingError: Error {
    case badRequest
    case failedParsing
    case failedEncoding
    case failedDownload
}
