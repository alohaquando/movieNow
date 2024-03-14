//
//  ChangePasswordView.swift
//  movienow
//
//  Created by Nhan, Nguyen Nguyen Ha on 13/09/2022.
//

import SwiftUI

// MARK: Input new password and confirm
struct AddNewPassword: View {
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var isUpdatedPassword = false
    @State var currentPassword = ""
    @State var newPassword = ""
    @State var newPasswordConfirm = ""
    
    var body: some View {
        if isUpdatedPassword {
            PasswordChangeView()
        } else {
            content
        }
    }
    
    var content: some View {
        VStack() {
            if authVM.isLoading {
                ProgressView()
            }
            
            Text(authVM.errorMessage)
            Form {
                HStack{
                    Text("Current:")
                    SecureField("Password", text: $currentPassword)
                        .padding(.leading, 30)
                }
                
                HStack{
                    Text("New:")
                    SecureField("New password", text: $newPassword)
                        .padding(.leading, 30)
                }
                
                HStack{
                    Text("Verify:")
                    SecureField("Verify new password", text: $newPasswordConfirm)
                        .padding(.leading, 20)
                }
            }
        }
        .navigationBarTitle("Change password", displayMode: .inline)
        .navigationBarItems(
            leading: Button(action: {dismiss()}, label: {Text("Cancel")}),
            trailing: Button(action: {
                authVM.changePassword(oldPassword: currentPassword, newPassword: newPassword)
                if authVM.errorMessage.isEmpty{
                    isUpdatedPassword = true
                }
            }, label: {
                Text("Change")
            }).disabled(newPassword.isEmpty || newPasswordConfirm.isEmpty || newPassword != newPasswordConfirm)
        )
        .navigationBarBackButtonHidden(true)
        .padding(.init(top: 30, leading: 20, bottom: 0, trailing: 20))
    }
}

// MARK: Confirm change successfully
struct PasswordChangeView: View {
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
            ZStack{
                Color(.black).edgesIgnoringSafeArea(.all)
                VStack{
                    VStack{
                        Text("Password changed")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .fontWeight(.heavy)
                            .padding(.bottom,8)
                        Text("Here’s to a more secure account")
                            .foregroundColor(.white.opacity(0.7))
                            .font(.system(size: 18))
                        
                    }.padding(.top,120)
                    Spacer()
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Back to profile")
                            .bold()
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 400)
                            .background(.blue)
                            .cornerRadius(15)
                    }
                }
                .padding()
            }
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewPassword()
        PasswordChangeView()
    }
}
