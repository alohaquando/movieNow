//
//  MovieListView.swift
//  movienow
//
//  Created by Quân Đỗ on 9/18/22.
//

import SwiftUI

import SwiftUISnappingScrollView

struct MovieListView: View {
    @State var showYourAccountViewSheet = false
    @State var showGenreSelectionViewSheet = false
    
    @StateObject var movies = MovieViewModel()
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        ZStack{
            
            // MARK: Movie list
            GeometryReader { proxy in
                SnappingScrollView(.vertical, decelerationRate: .fast, showsIndicators: false) {
                    ForEach(movies.movies, id: \.id) {movie in
                        VStack{
                            MovieListItem(movie: movie)
                                .frame(minHeight: proxy.size.height)
                        }.scrollSnappingAnchor(.bounds)
                        if movie == movies.movies.last {
                            LazyVStack{
                                MovieListItem(movie: movie)
                                    .frame(minHeight: proxy.size.height)
                            }
                            .scrollSnappingAnchor(.bounds)
                            .onVisible(action:  {isVisible in
                                if isVisible {
                                    movies.appendMovies(genre: String(authVM.chosenGenre ?? 12))
                                }
                            }
                            )
                        }
                    }
                }
            }.ignoresSafeArea()
            
            // MARK: Header
            VStack(spacing: 0){
                ZStack{
                    Rectangle()
                        .frame(height: 80)
                        .foregroundStyle( LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .top, endPoint: .bottom))
                        .ignoresSafeArea()
                    HStack{
                        Button(action: {showGenreSelectionViewSheet = true}) {
                            CircleIconButton(iconName: "magnifyingglass")
                        }.buttonStyle(.plain)
                        
                        Spacer()
                        
                        Button(action: {showYourAccountViewSheet = true}) {
                            CircleIconButton(iconName: "person")
                        }.buttonStyle(.plain)
                    }.padding()
                }
                Spacer()
            }
        }
        
        // TODO: Check value for chosenGenre
        .onAppear() {movies.appendMovies(genre: String(authVM.chosenGenre ?? 12))}
        .sheet(isPresented: $showYourAccountViewSheet) {
            if authVM.isUserLoggedIn {
                YourAccountView()
            } else {
                SignUpView(Skippable: false)
            }
        }
        .sheet(isPresented: $showGenreSelectionViewSheet) {
            GenreSelectionView()
        }
    }
}


struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
            .environmentObject(AuthViewModel())
    }
}
