//
//  LoginView.swift
//  movienow
//
//  Created by Nhan, Nguyen Nguyen Ha on 07/09/2022.
//

import SwiftUI

struct LogInView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color("AccountCreateBackground")
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Spacer()
                    Group {
                        Button (action: {
                            authVM.skipped = true
                        }, label: {
                            Text("Skip")
                                .foregroundColor(.white)
                        })
                    }
                    .padding(.init(top: 40, leading: 0, bottom: 0, trailing: 40))
                }
                Spacer()
                Group {
                    Text("Welcome back")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                    Text("Sign in with your account")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 40)
                }
                Group {
                    ZStack(alignment: .leading) {
                        TextField("Email", text: $authVM.signInEmail)
                            .font(.system(size: 17))
                            .foregroundColor(.white)
                    }
                    .padding(10)
                    .frame(height: 44)
                    .background(Color("TextFieldBackground"))
                    .cornerRadius(5)
                    ZStack(alignment: .leading) {
                        SecureField("Password", text: $authVM.signInPassword)
                            .font(.system(size: 17))
                            .foregroundColor(.white)
                    }
                    .padding(10)
                    .frame(height: 44)
                    .background(Color("TextFieldBackground"))
                    .cornerRadius(5)
                }
                .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
                
                Group {
                    Button(action: {
                        authVM.signIn()
                    }, label: {
                        HStack {
                            Spacer()
                            if authVM.isLoading {
                                ProgressView()
                            }
                            Text("Login")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .padding(.leading,10)
                            Spacer()
                        }
                        .frame(minWidth: 100, maxWidth: .infinity)
                    })
                    .padding(15)
                    .background(.blue)
                    .cornerRadius(10)
                    .padding(.init(top: 20, leading: 20, bottom: 5, trailing: 20))
                    
                    
                    Text(authVM.errorMessage)
                        .foregroundColor(.red)
                        .padding(.bottom, 10)
                        .padding(.horizontal,20)
                    
                    
                    HStack {
                        Text("Don't have any account?")
                            .foregroundColor(.gray)
                        Button(action: {
                            dismiss()
                        }, label: {
                            Text("Sign up")
                        })
                    }
                }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
