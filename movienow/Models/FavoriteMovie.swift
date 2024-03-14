//
//  Favorite.swift
//  movienow
//
//  Created by Tuan Nguyen on 9/11/22.
//

import Foundation
import FirebaseFirestore

struct FavoriteMovie: Codable, Identifiable {
    var id: String = UUID().uuidString
    var uid: String?
    var userId: String?
    var movie: Movie?
    var providers: [ProviderDetail]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case movie
        case providers
    }
    
    func createDictionary() -> [String: Any]? {
        guard let dictionary = self.toDictionary else {
            return nil
        }
        
        return dictionary
    }
    
    static func fromDocument(document: DocumentSnapshot) -> FavoriteMovie {
        return FavoriteMovie(
            id: document.get("id") as? String ?? "",
            uid: document.documentID,
            userId: document.get("user_id") as? String ?? "",
            movie: Movie.fromDictionary(dictionary: document.get("movie") as? [String : Any] ?? [:]),
            providers: (document.get("providers") as? [[String : Any]] ?? [[:]]).map { doc -> ProviderDetail in
                return ProviderDetail.fromDictionary(dictionary: doc)!
            }
            
        )
    }
}
