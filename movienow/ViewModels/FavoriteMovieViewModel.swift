//
//  FavoritesViewModel.swift
//  movienow
//
//  Created by Tuan Nguyen on 9/12/22.
//

import Foundation
import FirebaseFirestore

class FavoriteMovieViewModel: ObservableObject {
    @Published var movies: [FavoriteMovie] = [FavoriteMovie]()
    
    private var db = Firestore.firestore()
    
    func addMovie(userId: String, movie: Movie, providers: [ProviderDetail]) {
        let favorite = FavoriteMovie(userId: userId, movie: movie, providers: providers)
        if let favDic = favorite.createDictionary() {
            db.collection("favorite-movies").addDocument(data: favDic)
        }
    }
    
    func getMovies(userId: String) {
        db.collection("favorite-movies").whereField("user_id", isEqualTo: userId).addSnapshotListener { documentSnapshot, error in
            guard let documents = documentSnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.movies = documents.map { documentSnapshot -> FavoriteMovie in
                return FavoriteMovie.fromDocument(document: documentSnapshot)
            }
        }
    }
    
    func deleteMovie(uid: String) {
        db.collection("favorite-movies").document(uid).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}
