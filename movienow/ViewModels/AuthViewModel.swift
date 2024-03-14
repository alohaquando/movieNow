//
//  AuthViewModel.swift
//  movienow
//
//  Created by Tuan Nguyen on 9/11/22.
//

import Foundation
import Firebase

let DEFAULT_ERROR = "Something wrong happened"

class AuthViewModel: ObservableObject {
    @Published var signUpEmail: String = ""
    @Published var signUpPassword: String = ""
    
    @Published var signInEmail: String = ""
    @Published var signInPassword: String = ""
    
    @Published var chosenGenre: Int? = nil
    @Published var isGenreFilled: Bool = false
    
    @Published var user: User = User()
    @Published var userInfo: UserInfo = UserInfo()
    
    @Published var isUserLoggedIn = false
    @Published var isUserSignedUp = false
    
    @Published var isLoading = false
    @Published var errorMessage = ""
    
    @Published var skipped = false
    
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    
    // MARK: set genre
    func setGenre(genre: Int?) {
        if let genre = genre {
            self.chosenGenre = genre
            self.isGenreFilled = true
        }
    }
    
    // MARK: get user
    func getUser() {
        
        isLoading = true
        
        self.auth.addStateDidChangeListener { auth, user in
            self.isLoading = false
            if user != nil {
                self.user = User(uid: self.auth.currentUser?.uid ?? "", email: self.auth.currentUser?.email ?? "")
            }
            
        }
    }
    
    func getUserInfo() {
        
        isLoading = true
        
        self.db.collection("users").whereField("user_id", isEqualTo: self.user.uid ?? "").addSnapshotListener { documentSnapshot, error in
            self.isLoading = false
            guard let documents = documentSnapshot?.documents else {
                print("No documents")
                return
            }
            
            if documents.count > 0 {
                self.userInfo = UserInfo.fromDocument(document: documents[0])
            }
        }
    }
    
    // MARK: sign up
    func signUp() {
        
        isLoading = true
        errorMessage = ""
        
        self.auth.createUser(withEmail: self.signUpEmail, password: self.signUpPassword) { authResult, error in
            if error != nil {
                self.isLoading = false
                self.errorMessage = error?.localizedDescription ?? DEFAULT_ERROR
                self.isUserLoggedIn = false
            } else {
                self.db.collection("users").addDocument(data: [
                    "genre": self.chosenGenre ?? -1,
                    "user_id": self.user.uid ?? ""
                ]) { err in
                    self.isLoading = false
                    self.errorMessage = ""
                    if let err = err {
                        print("Error adding document: \(err)")
                    }
                }
                
                self.getUserInfo()
                
                self.chosenGenre = nil
                self.isUserSignedUp = true
            }
        }
        
    }
    
    // MARK: sign in
    func signIn() {
        
        isLoading = true
        errorMessage = ""
        
        self.auth.signIn(withEmail: self.signInEmail, password: self.signInPassword) { result, error in
            if error != nil {
                self.isLoading = false
                self.errorMessage = error?.localizedDescription ?? DEFAULT_ERROR
                self.isUserLoggedIn = false
            } else {
                self.errorMessage = ""
                self.isLoading = false
                self.getUserInfo()
                
                // if users choose another genre, update it
                self.db.collection("users").document(self.userInfo.uid ?? "1").updateData([
                    "genre": self.chosenGenre ?? -1,
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    }
                }
                
                
                self.chosenGenre = nil
                self.isGenreFilled = false
                self.isUserLoggedIn = true
            }
        }
    }
    
    // MARK: sign out
    func signOut() {
        
        isLoading = true
        errorMessage = ""
        
        do {
            try self.auth.signOut()
            self.isLoading = false
            self.isUserLoggedIn = false
            self.skipped = false
            self.isGenreFilled  = false
        }
        catch{
            self.errorMessage = "Error signing out. Try again later."
        }
    }
    
    // MARK: change password
    func changePassword(oldPassword: String, newPassword: String) {
        
        isLoading = true
        errorMessage = ""
        
        self.auth.signIn(withEmail: user.email ?? "", password: oldPassword) { result, error in
            if error != nil {
                self.isLoading = false
                self.errorMessage = error?.localizedDescription ?? DEFAULT_ERROR
            } else {
                self.auth.currentUser?.updatePassword(to: newPassword) { error in
                    self.isLoading = false
                    if error != nil {
                        self.errorMessage = error?.localizedDescription ?? DEFAULT_ERROR
                    }else{
                        self.errorMessage = ""
                    }
                }
            }
        }
    }
    
    // MARK: change username
    func changeName(newName: String) {
        
        isLoading = true
        errorMessage = ""
        
        self.db.collection("users").document(self.userInfo.uid ?? "1").updateData([
            "name": newName
        ]) { err in
            self.isLoading = false
            if let err = err {
                self.errorMessage = "Error changing name. Try again later."
                print("Change name" , err)
            }
        }
    }
    
    // MARK: change genre
    func changeGenre(newGenre: Int) {
        
        isLoading = true
        errorMessage = ""
    
        self.db.collection("users").document(self.userInfo.uid ?? "1").updateData([
            "genre": newGenre,
        ]) { err in
            self.isLoading = false
            if let _ = err {
                self.errorMessage = "Error changing genre. Try again later."
            }
        }
    }
}
