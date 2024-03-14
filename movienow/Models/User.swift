//
//  User.swift
//  movienow
//
//  Created by Tuan Nguyen Anh on 13/09/2022.
//

import Foundation
import FirebaseFirestore

struct User: Identifiable, Codable {
    var id: String = UUID().uuidString
    var uid: String?
    var email: String?
    
    static func fromDocument(document: DocumentSnapshot) -> User {
        return User(
            id: document.get("id") as? String ?? "",
            uid: document.documentID,
            email: document.get("email") as? String ?? ""
        )
    }
}
