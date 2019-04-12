//
//  Codable+Dictionary.swift
//  AHTVmazeDemo
//
//  Created by Andreas Hörberg on 2019-04-11.
//  Copyright © 2019 Andreas Hörberg. All rights reserved.
//

import Foundation

extension Encodable {
    public func asDictionary() -> [String: Any]? {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(self) else { return nil }
        guard let optional = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else { return nil }
        guard let dictionary = optional as? [String: Any] else { return nil }
        return dictionary
    }
}

extension Decodable {
    public static func from(_ dict: [String: Any]) -> Self? {
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(Self.self, from: data)
    }
}
