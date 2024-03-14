//
//  StartView.swift
//  movienow
//
//  Created by Ngan Phan Thi Thu on 31/08/2022.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @StateObject var genreVM: GenreViewModel = GenreViewModel()
    
    var body: some View {
        if authVM.isUserLoggedIn || authVM.skipped {
            MovieListView()
        } else {
            content
                .onAppear {
                    authVM.getUser()
                }
        }
    }
    
    var content: some View {
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
                
                ZStack{
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(genreVM.genres, id: \.id){ genre in
                                VStack {
                                    Button {
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
        .sheet(isPresented: $authVM.isGenreFilled) {
            SignUpView(Skippable: true)
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
            .environmentObject(AuthViewModel())
    }
}
