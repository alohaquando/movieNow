//
//  TempMovieView.swift
//  movienow
//
//  Created by Tuan Nguyen Anh on 15/09/2022.
//

import SwiftUI

struct TempMovieView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @StateObject private var movieVM = MovieViewModel()
    @StateObject private var providerVM = ProviderViewModel()
    @StateObject private var favMovieVM = FavoriteMovieViewModel()
    
    @State var showingSheet = false
    
    func getGenre() -> Int {
        return authVM.userInfo.genre ?? 0
    }
    
    var body: some View {
        VStack {
//            Text(authVM.userInfo.name ?? "")
//
//            Text("Movie View")
//                .onAppear {
//                    let _ = print(getGenre())
//                    movieVM.appendMovies(genre: String(getGenre()))
//                    if movieVM.movies.count > 0 {
//                        providerVM.getProviders(movieId: movieVM.movies[0].id ?? 0)
//                    }
//                }
//
//            Button {
//                favMovieVM.addMovie(userId: authVM.user.uid ?? "", movie: movieVM.movies, providers: providerVM.providers)
//            } label: {
//                Text("Add more movie")
//            }
//
//            AsyncImage(url: URL(string: movieVM.getImageUrl(path: favMovieVM.movies.count > 0 ? favMovieVM.movies[0].movie?.posterPath ?? "" : "")))
//                .task {
//                    favMovieVM.getMovies(userId: authVM.user.uid ?? "")
//                }
//
            Button {
                showingSheet = true
            } label: {
                Text("To Account")
            }
        }
        
        .sheet(isPresented: $showingSheet) {
            YourAccountView()
        }
    }
}

struct TempMovieView_Previews: PreviewProvider {
    static var previews: some View {
        TempMovieView()
            .environmentObject(AuthViewModel())
    }
}
