//
//  GenreViewModel.swift
//  movienow
//
//  Created by Tuan Nguyen Anh on 13/09/2022.
//

import Foundation

struct GenreVMKeys {
    static let BASE_URL = "\(TmdbConfigs.BASE_URL)genre/movie/list?api_key=\(TmdbConfigs.API_KEY)&language=en-US"
}

class GenreViewModel: ObservableObject {
    @Published var genres: [Genre] = [Genre]()
    
    func getGenres() {
        let url = GenreVMKeys.BASE_URL
        
        self.genres = decodeGenreResult(url: url)
    }
}
