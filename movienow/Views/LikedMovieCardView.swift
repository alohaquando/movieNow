//
//  LikedMovieCardView.swift
//  movienow
//
//  Created by Ngan Phan Thi Thu on 05/09/2022.
//

import SwiftUI

struct LikedMovieCardView: View {
    let movie: Movie
    
    func getPosterUrl() -> String {
        return "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")"
    }
    
    var body: some View {
        VStack{
            
            AsyncImage(
                url: URL(string: getPosterUrl()),
                content: { image in
                    image
                        .centerCropped()
                        .frame(width: .infinity, height: 150
                        )
                        .cornerRadius(7)
                },
                placeholder: {
                    ProgressView()
                        .padding()
                }
            )
                
            HStack{
                Text(movie.title ?? "")
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }.font(.body)
                .padding(.top, 4)
                .padding(.bottom, 8)
        }
        .padding(.top, 12)
        .padding(.bottom, 8)
    }
}

struct LikedMovieCardView_Previews: PreviewProvider {
    static let movie = Movie(adult: false, backdropPath: "", genreIDS: [1], id: 1234, originalLanguage: "English", originalTitle: "Everything Everywhere All at Once", overview: "When an interdimensional rupture unravels reality, an unlikely hero must channel her newfound powers to fight bizarre and bewildering dangers from the multiverse as the fate of the world hangs in the balance.", popularity: 4.8, posterPath: "", releaseDate: "20 May 2020", title: "Everything Everywhere All at once", video: true, voteAverage: 4.9, voteCount: 593)
    static var previews: some View {
        LikedMovieCardView(movie: movie)
    }
}
