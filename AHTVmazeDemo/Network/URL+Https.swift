//
//  URL+Https.swift
//  AHTVmazeDemo
//
//  Created by Andreas Hörberg on 2019-04-12.
//  Copyright © 2019 Andreas Hörberg. All rights reserved.
//

import Foundation

extension URL {
    func toHttps() -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else { return self }
        components.scheme = "https"
        guard let httpsURL = components.url else { return self }
        return httpsURL
    }
}
