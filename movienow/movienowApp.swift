//
//  movienowApp.swift
//  movienow
//
//  Created by Tuan Nguyen Anh on 31/08/2022.
//

import SwiftUI
import Firebase

@main
struct movienowApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    @StateObject private var authVM = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(authVM)
        }
    }
}
