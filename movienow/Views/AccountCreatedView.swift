//
//  AccountCreatedView.swift
//  movienow
//
//  Created by Ngan Phan Thi Thu on 14/09/2022.
//

import SwiftUI

struct AccountCreatedView: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    @State private var fullname: String = ""
    
    var body: some View {
        ZStack {
            Color(.black)
                .edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                Group {
                    Text("Account created")
                        .font(.system(size: 30, design: .rounded))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                    Text("What's your full name")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 40)
                }.padding(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
                
                Group {
                    ZStack(alignment: .leading) {
                        if fullname.isEmpty {
                            Text("Full Name")
                                .foregroundColor(.white.opacity(0.4))
                                .font(.system(size: 15))
                                .background(Color(red: 0.141, green: 0.141, blue: 0.141))
                        }
                        TextField("", text: $fullname)
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                    }
                    .padding(13)
                    .background(Color(red: 0.141, green: 0.141, blue: 0.141))
                    .cornerRadius(5)
                }.padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                
                Group {
                    Button(action: {
                        self.authVM.changeName(newName: fullname)
                        if authVM.errorMessage.isEmpty {
                            
                            self.authVM.isUserLoggedIn = true
                            self.authVM.isGenreFilled = false
                            self.authVM.isUserSignedUp = false
                            
                        }
                    }, label: {
                        HStack {
                            Spacer()
                            if authVM.isLoading {
                                ProgressView()
                            }
                            Text("Take me to the movie")
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
                    .padding(.init(top: 0, leading: 20, bottom: 20, trailing: 20))
                    
                    Text(authVM.errorMessage)
                        .foregroundColor(.red)
                        .padding(.bottom, 10)
                        .padding(.horizontal,20)
                    
                }
                Spacer()
            }
        }
    }
}

struct AccountCreatedView_Previews: PreviewProvider {
    static var previews: some View {
        AccountCreatedView()
    }
}
