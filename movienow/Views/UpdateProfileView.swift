//
//  UpdateProfile.swift
//  movienow
//
//  Created by Ngan Phan Thi Thu on 31/08/2022.
//

import SwiftUI

struct UpdateProfileView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var editButton = false
    @State var fullname: String = ""
    @State var isUpdated = false
    
    var body: some View {
        if isUpdated {
            ProfileUpdatedView()
        } else {
            content
        }
    }
    
    var content: some View {
        ZStack{
            VStack{
                VStack(alignment: .center){
                    Circle()
                        .fill(.black.opacity(0.5))
                        .frame(width: 130, height: 130, alignment: .center)
                        .overlay(
                            Image(systemName: "person")
                                .font(.system(size: 70))
                        )
                }
                .padding(.top, 30)
                
                Form {
                    Section {
                        HStack{
                            Text("Full Name")
                            TextField(authVM.userInfo.name ?? "", text: $fullname)
                        }
                    }
                }
                
                if authVM.isLoading{
                    ProgressView()
                }
                
                Spacer()
            }
        }
        .navigationTitle("Update profile")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if !fullname.isEmpty {
                        authVM.changeName(newName: fullname)
                    }
                    isUpdated = true
                } label: {
                    Text("Save")
                }
            }
        }
    }
}

struct UpdateProfile_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProfileView()
    }
}
