//
//  Genre.swift
//  movienow
//
//  Created by Tuan Nguyen Anh on 13/09/2022.
//

import Foundation

// MARK: - GenreResult
struct GenreResult: Codable {
    let genres: [Genre]?
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}
