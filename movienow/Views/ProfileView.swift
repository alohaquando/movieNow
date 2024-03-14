//
//  ProfileView.swift
//  movienow
//
//  Created by Ngan Phan Thi Thu on 31/08/2022.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            VStack{
                VStack{
                    Circle()
                        .fill(.black.opacity(0.5))
                        .frame(width: 130, height: 130, alignment: .center)
                        .overlay(
                            Image(systemName: "person")
                                .font(.system(size: 70))
                        )
                    
                    Text(authVM.userInfo.name ?? "")
                        .font(.system(size: 25))
                }
                .padding(.top, 30)
                
                Form {
                    Section {
                        NavigationLink {
                            UpdateProfileView()
                        } label: {
                            Text("Update profile")
                        }
                        
                        NavigationLink {
                            AddNewPassword()
                        } label: {
                            Text("Change password")
                        }
                    }
                    
                    Section {   
                        Button {
                            authVM.signOut()
                        } label: {
                            Text("Log out")
                                .foregroundColor(.red)
                        }
                    }
                }
                
                Spacer()
            }
        }
        .navigationTitle("Profile")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            Button {
                dismiss()
            } label: {
                Text("Done")
            }

        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
