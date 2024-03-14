//
//  AccountCreateView.swift
//  movienow
//
//  Created by Nhan, Nguyen Nguyen Ha on 31/08/2022.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    let Skippable: Bool
    
    // Later, please connect this view to the main view as a modal view, using .sheet()
    var body: some View {
        NavigationView {
            ZStack {
                Color("AccountCreateBackground")
                    .edgesIgnoringSafeArea(.all)
                
                NavigationLink(isActive: $authVM.isUserSignedUp) {
                    AccountCreatedView()
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
                } label: {
                    EmptyView()
                }
                
                VStack {
                    HStack {
                        Spacer()
                        if (Skippable) {
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
                    }
                    Spacer()
                    Group {
                        Text("Save your movie taste")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.bottom, 5)
                        Text("Create an account to see movies\ntailored to you everytime")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 40)
                    }
                    Group {
                        ZStack(alignment: .leading) {
                            TextField("Email", text: $authVM.signUpEmail)
                                .font(.system(size: 17))
                                .foregroundColor(.white)
                        }
                        .padding(10)
                        .frame(height: 44)
                        .background(Color("TextFieldBackground"))
                        .cornerRadius(5)
                        ZStack(alignment: .leading) {
                            SecureField("Password", text: $authVM.signUpPassword)
                                .font(.system(size: 17))
                                .foregroundColor(.white)
                        }
                        .padding(10)
                        .frame(height: 44)
                        .background(Color("TextFieldBackground"))
                        .cornerRadius(5)
                        .padding(.bottom, 20)
                    }
                    .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
                    Group {
                        Button(action: {
                            authVM.signUp()
                        }, label: {
                            HStack {
                                Spacer()
                                if authVM.isLoading {
                                    ProgressView()
                                }
                                Text("Create Account")
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
                        .padding(.init(top: 0, leading: 20, bottom: 5, trailing: 20))
                        
                        Text(authVM.errorMessage)
                            .foregroundColor(.red)
                            .padding(.bottom, 10)
                            .padding(.horizontal,20)
                        
                        HStack {
                            Text("Already have an account?")
                                .foregroundColor(.gray)
                            Button (action: {
                                dismiss()
                            }, label: {
                                NavigationLink(destination: LogInView()) {
                                    Text("Sign in")
                                }
                                .navigationBarBackButtonHidden(true)
                                .navigationBarHidden(true)
                            })
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(Skippable: false)
    }
}
