//
//  YourAccountView.swift
//  movienow
//
//  Created by Ngan Phan Thi Thu on 05/09/2022.
//

import SwiftUI

struct YourAccountView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var genreVM: GenreViewModel = GenreViewModel()
    @StateObject var favorites = FavoriteMovieViewModel()
    @StateObject private var movieVM: MovieViewModel = MovieViewModel()
    
    @State private var showingSheet = false
    @State private var id = 0
    @State private var chosenGenre = ""
    
    // Change to show liked movies list
    @StateObject var movies = MovieViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                //account
                Section{
                    NavigationLink {
                        ProfileView()
                    } label: {
                        HStack(){
                            Circle()
                                .fill(.black.opacity(0.5))
                                .frame(width: 60, height: 60, alignment: .leading)
                                .overlay(
                                    Image(systemName: "person")
                                        .font(.system(size: 32))
                                )
                                .padding(.trailing,10)
                            
                            VStack(alignment: .leading) {
                                Text(authVM.userInfo.name ?? "")
                                    .bold()
                                    .font(.system(size: 25))
                                    .padding(.bottom,4)
                                Text(authVM.user.email ?? "")
                                    .font(.system(size: 18))
                            }
                        }
                    }
                    
                }
                .padding()
                .listRowInsets(EdgeInsets())
                
                //genre
                Section{
                    Picker("Genre \(chosenGenre)", selection: $id){
                        ForEach(genreVM.genres, id: \.id) { genre in
                            Text(genre.name ?? "")
                                .tag(genre.id ?? 0)
                        }
                    }
                    .onChange(of: id) { id in
                        authVM.changeGenre(newGenre: id)
                    }
                }
                .onAppear {
                    genreVM.getGenres()
                }
                
                Text("Liked movies")
                    .font(.callout)
                    .fontWeight(.medium)
                    .opacity(0.5)
                
                // TODO: Fix isLiked state
                // TODO: Make sure movies are passed correctly
                ForEach(favorites.movies, id: \.id) {favMovie in
                    ZStack(alignment: .leading) {
                        NavigationLink{
                            MovieDetailView(movie: favMovie.movie!, backIcon: "chevron.left", isLiked: .constant(true))
                        } label: {
                            EmptyView()
                        }.opacity(0)
                        LikedMovieCardView(movie: favMovie.movie!)
                    }
                    // TODO: Make sure userID is passed correctly

                }.onAppear() {favorites.getMovies(userId: authVM.userInfo.uid ?? "")}
            }
            .navigationTitle("Your Account")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Text("Done")
                }
            }
        }
    }
}
struct YourAccountView_Previews: PreviewProvider {
    static var previews: some View {
        YourAccountView()
            .environmentObject(AuthViewModel())
    }
}
