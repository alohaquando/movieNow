//
//  MovieListItem.swift
//  movienow
//
//  Created by Quân Đỗ on 9/18/22.
//

import SwiftUI

struct MovieListItem: View {
    @EnvironmentObject var authVM: AuthViewModel
    @StateObject var providers = ProviderViewModel()
    @StateObject var favorites = FavoriteMovieViewModel()
    @State var showSignUpViewSheet = false
    
    let movie: Movie
    
    // MARK: Movie isLiked
    @State var isLiked = false
    
    // TODO: Make sure userID is passed correctly
    
    func handleLike() {
        if authVM.isUserLoggedIn {
            if isLiked {
                favorites.addMovie(userId: authVM.userInfo.uid ?? "", movie: movie, providers: providers.providers)
            } else {
                favorites.deleteMovie(uid: "")
            }
            isLiked = !isLiked
        } else {
            showSignUpViewSheet = true
        }
    }
    
    func getPosterUrl() -> String {
        return "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")"
    }
    
    // MARK: Movie detail sheet
    @State var showMovieDetailViewSheet = false
    
    var body: some View {
        ZStack{
            
            // MARK: Image
            AsyncImage(
                url: URL(string: getPosterUrl()),
                content: { image in
                    image
                        .centerCropped()
                        .ignoresSafeArea()
                        .brightness(-0.03)
                        .overlay(
                            Rectangle().ignoresSafeArea().foregroundColor(.black).opacity(0.3)
                        )
                },
                placeholder: {
                    ProgressView()
                }
            )
            
            
            // Shadow
            VStack {
                Spacer()
                Rectangle()
                    .frame(height: 500)
                    .foregroundStyle( LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .bottom, endPoint: .top))
            }
            .ignoresSafeArea()
            
            
            // MARK: Main content
            VStack(spacing: 16) {
                Spacer()
                
                // Movie and favorite icon button
                HStack(alignment: .top) {
                    // MARK: Movie name
                    Text(movie.title ?? "")
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    // MARK: Favorite icon button
                    Button(action: {handleLike()}) {
                        if (isLiked) {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40)
                                .padding(.top)
                                .foregroundColor(.red)
                        } else {
                            Image(systemName: "heart")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40)
                                .padding(.top)
                        }
                    }.buttonStyle(.plain)
                }
                
                // MARK: Movie info bar
                MovieInfoBar(voteAverage: movie.voteAverage ?? 0, tag1: movie.releaseDate ?? "")
                
                // MARK: Description
                Text(movie.overview ?? "No description available")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(3)
                    .lineSpacing(8)
                    .opacity(0.8)
                
                // MARK: Swipe indicator
                VStack(spacing: 8){
                    Text("Swipe for more")
                        .font(.caption2)
                    Image(systemName: "chevron.down")
                }
                .opacity(0.4)
                .padding(.top, 10)
                
                Spacer().frame(height: 20)
            }
            .padding()
        }
        .onAppear() {providers.getProviders(movieId: movie.id!)}
        .onTapGesture {showMovieDetailViewSheet = true}
        .sheet(isPresented: $showMovieDetailViewSheet) {
            MovieDetailView(movie: movie, backIcon: "chevron.down", isLiked: $isLiked)
        }
        .sheet(isPresented: $showSignUpViewSheet) {
            SignUpView(Skippable: false)
        }
    }
}

struct MovieListItem_Previews: PreviewProvider {
    static let movie = Movie(adult: false, backdropPath: "", genreIDS: [1], id: 1234, originalLanguage: "English", originalTitle: "Everything Everywhere All at Once", overview: "When an interdimensional rupture unravels reality, an unlikely hero must channel her newfound powers to fight bizarre and bewildering dangers from the multiverse as the fate of the world hangs in the balance.", popularity: 4.8, posterPath: "", releaseDate: "20 May 2020", title: "Everything Everywhere All at once", video: true, voteAverage: 4.9, voteCount: 593)
    static var previews: some View {
        MovieListItem(movie: movie)
            .environmentObject(AuthViewModel())
    }
}
