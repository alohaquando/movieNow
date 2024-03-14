//
//  UserInfo.swift
//  movienow
//
//  Created by Tuan Nguyen Anh on 13/09/2022.
//

import Foundation
import FirebaseFirestore

struct UserInfo: Identifiable, Codable {
    var id: String = UUID().uuidString
    var uid: String?
    var name: String?
    var genre: Int?
    var userId: String?
    
    static func fromDocument(document: DocumentSnapshot) -> UserInfo {
        return UserInfo(
            id: document.get("id") as? String ?? "",
            uid: document.documentID,
            name: document.get("name") as? String ?? "",
            genre: document.get("genre") as? Int ?? -1,
            userId: document.get("user_id") as? String ?? ""
        )
    }
}

