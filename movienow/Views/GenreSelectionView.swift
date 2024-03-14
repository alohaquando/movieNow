//
//  GenreSelectionView.swift
//  movienow
//
//  Created by Quân Đỗ on 9/18/22.
//

import SwiftUI

struct GenreSelectionView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @StateObject var genreVM: GenreViewModel = GenreViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack{
            VStack{
                ZStack{
                    LinearGradient(
                        colors: [.orange, .purple,.blue],
                        startPoint: .leading,
                        endPoint:.trailing)
                    .edgesIgnoringSafeArea(.all)
                    LinearGradient(
                        colors: [.clear, .black],
                        startPoint: .top,
                        endPoint:.bottom)
                    .edgesIgnoringSafeArea(.all)
                    
                    Text("I'm in the mood for")
                        .foregroundColor(.white)
                        .font(.system(.largeTitle))
                        .padding(.vertical, 100)
                }.frame(height: 280)
                
                // TODO: Chosing a genre here doesn't refresh movie list
                ZStack{
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(genreVM.genres, id: \.id){ genre in
                                VStack {
                                    Button {
                                        presentationMode.wrappedValue.dismiss()
                                        authVM.setGenre(genre: genre.id ?? -1)
                                    } label: {
                                        HStack{
                                            Text(genre.name ?? "")
                                                .foregroundColor(.white)
                                                .font(.system(.title2))
                                            
                                            Spacer()
                                        }
                                        .padding(20)
                                        .background(Color("SurfaceColor"))
                                        .cornerRadius(16)
                                    }
                                }
                            }
                        }.padding()
                            .padding(.top, 24)
                    }
                    .task {
                        genreVM.getGenres()
                    }
                    
                    VStack{
                        LinearGradient(
                            colors: [.black, .clear],
                            startPoint: .top,
                            endPoint:.bottom)
                        .frame(height: 24)
                        .allowsHitTesting(false)
                        Spacer()
                    }
                }
            }
        }.background(.black)
    }
}

struct GenreSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        GenreSelectionView()
    }
}
