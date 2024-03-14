//
//  decodeJson.swift
//  movienow
//
//  Created by Tuan Nguyen Anh on 07/09/2022.
//

import Foundation

func decodeDiscoverMovie(url: String) -> [Movie] {
    if let url = URL(string: url) {
        if let data = try? Data(contentsOf: url) {
            do {
                let decoded = try JSONDecoder().decode(DiscoverMovie.self, from: data)
                return decoded.results ?? [Movie]()
            } catch let error {
                fatalError("Failed to decode JSON: \(error)")
            }
        }
    }
    
    return [] as [Movie]
}

func decodeWatchProvider(url: String) -> ProviderCoutries? {
    if let url = URL(string: url) {
        if let data = try? Data(contentsOf: url) {
            do {
                let decoded = try JSONDecoder().decode(WatchProvider.self, from: data)
                return decoded.results
            } catch let error {
                fatalError("Failed to decode JSON: \(error)")
            }
        }
    }
    
    return nil
}

func decodeGenreResult(url: String) -> [Genre] {
    if let url = URL(string: url) {
        if let data = try? Data(contentsOf: url) {
            do {
                let decoded = try JSONDecoder().decode(GenreResult.self, from: data)
                return decoded.genres ?? [Genre]()
            } catch let error {
                fatalError("Failed to decode JSON: \(error)")
            }
        }
    }
    
    return [] as [Genre]
}
