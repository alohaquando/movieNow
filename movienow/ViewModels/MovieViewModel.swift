//
//  MovieViewModel.swift
//  movienow
//
//  Created by Tuan Nguyen Anh on 07/09/2022.
//

import Foundation

struct MovieVMKeys {
    static let BASE_URL = "\(TmdbConfigs.BASE_URL)discover/movie?api_key=\(TmdbConfigs.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&with_watch_monetization_types=flatrate"
    static let IMAGE_BASE_URL = "https://image.tmdb.org/t/p/w500"
    static let MIN_PAGE = 1
    static let MAX_PAGE = 500
    static let GENRE_KEY = "with_genres"
    static let PAGE_KEY = "page"
}

class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = [Movie]()
    
    func appendMovies(genre: String) {
        let page = Int.random(in: MovieVMKeys.MIN_PAGE...MovieVMKeys.MAX_PAGE)
        
        let movies = fetchMovie(genre: genre, page: page)
        
        self.movies += movies
    }
    
    func fetchMovie(genre: String, page: Int) -> [Movie] {
        let url = "\(MovieVMKeys.BASE_URL)&\(MovieVMKeys.GENRE_KEY)=\(genre)&\(MovieVMKeys.PAGE_KEY)=\(page)"
        
        return decodeDiscoverMovie(url: url)
    }
    
    func getImageUrl(path: String) -> String {
        return "\(MovieVMKeys.IMAGE_BASE_URL)\(path)"
    }
}
