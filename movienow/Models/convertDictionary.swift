//
//  convertDictionary.swift
//  movienow
//
//  Created by Tuan Nguyen Anh on 12/09/2022.
//

import Foundation

extension Encodable {
    var toDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    
    static func fromDictionary<T: Decodable>(dictionary: [String: Any]) -> T? {
        guard let data = try? JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: dictionary)) else { return nil }
        return data
    }
}
