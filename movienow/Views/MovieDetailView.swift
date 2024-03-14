//
//  MovieDetailView.swift
//  movienow
//
//  Created by Quân Đỗ on 9/18/22.
//

import SwiftUI

struct MovieDetailView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    @StateObject var providers = ProviderViewModel()
    @StateObject var favorites = FavoriteMovieViewModel()
    @State var showSignUpViewSheet = false
    
    let movie: Movie
    
    let backIcon: String
    
    func getImg() -> String {
        return "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")"
    }
    
    // MARK: Movie isLiked
    @Binding var isLiked: Bool
    
    // TODO: Add uid
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
    
    var body: some View {
        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            
            VStack(spacing: 0){
                // MARK: Header
                ZStack(alignment: .bottomLeading) {
                    
                    // MARK: Image
                    AsyncImage(
                        url: URL(string: getImg()),
                        content: { image in
                            image
                                .centerCropped()
                        },
                        placeholder: {
                            ProgressView()
                        }
                    )
                    
                    // Shadow
                    VStack {
                        Rectangle()
                            .frame(height: 80)
                            .foregroundStyle( LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .top, endPoint: .bottom))
                        Spacer()
                        Rectangle()
                            .frame(height: 120)
                            .foregroundStyle( LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .bottom, endPoint: .top))
                    }
                    .ignoresSafeArea()
                    
                    // MARK: Buttons
                    VStack{
                        HStack{
                            Button(action: {presentationMode.wrappedValue.dismiss()}) {
                                CircleIconButton(iconName: backIcon)
                            }.buttonStyle(.plain)
                            
                            Spacer()
                            
                            Button(action: {handleLike()}) {
                                if (!isLiked) {
                                    CircleIconButton(iconName: "heart")
                                } else {
                                    CircleIconButton(iconName: "heart.fill")
                                        .foregroundColor(.red)
                                }
                            }.buttonStyle(.plain)
                        }
                        .frame(height: 40)
                        .padding()
                        .padding(.top, 2)
                        
                        Spacer()
                    }
                    
                    // MARK: Movie name
                    Text(movie.title ?? "")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                        .padding(.bottom, 8)
                        .padding(.leading, 16)
                }
                .frame(height: 280)
                .clipped()
                
                // MARK: Content
                ScrollView{
                    VStack{
                        
                        VStack(spacing: 16) {
                            
                            // MARK: Info bar
                            MovieInfoBar(voteAverage: movie.voteAverage ?? 0, tag1: movie.releaseDate ?? "")
                            
                            // MARK: Description
                            Text(movie.overview ?? "No description available")
                                .lineSpacing(8)
                                .opacity(0.8)
                            
                            // MARK: Now showing section
                            
                            if (providers.providers.count != 0) {
                                VStack{
                                    HStack{
                                        Text("NOW SHOWING ON")
                                            .fontWeight(.medium)
                                            .opacity(0.5)
                                        Spacer()
                                    }
                                    ForEach(providers.providers, id: \.providerID) { provider in
                                        ProviderListItem(provider: provider)
                                    }
                                }
                                .padding(.top)
                            } else {
                                Text("This movie is not available on any services yet")
                                    .padding(.top, 16)
                                    .font(.callout)
                                    .opacity(0.5)
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .onAppear() {providers.getProviders(movieId: movie.id!)}
        .navigationBarHidden(true)
        .sheet(isPresented: $showSignUpViewSheet) {
            SignUpView(Skippable: false)
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static let movie = Movie(adult: false, backdropPath: "", genreIDS: [1], id: 1234, originalLanguage: "English", originalTitle: "Everything Everywhere All at Once", overview: "When an interdimensional rupture unravels reality, an unlikely hero must channel her newfound powers to fight bizarre and bewildering dangers from the multiverse as the fate of the world hangs in the balance.", popularity: 4.8, posterPath: "", releaseDate: "20 May 2020", title: "Everything Everywhere All at once", video: true, voteAverage: 4.9, voteCount: 593)
    static var previews: some View {
        MovieDetailView(movie: movie, backIcon: "chevron.down", isLiked: .constant(true))
            .environmentObject(AuthViewModel())
    }
}
