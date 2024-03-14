//
//  ProfileUpdatedView.swift
//  movienow
//
//  Created by Ngan Phan Thi Thu on 31/08/2022.
//

import SwiftUI

struct ProfileUpdatedView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            VStack{
                VStack{
                    Text("Profile updated")
                        .font(.system(size: 30))
                        .fontWeight(.heavy)
                        .padding(.bottom,8)
                    Text("Nice job keeping things up to date")
                        .font(.system(size: 18))
                    
                }.padding(.top,120)
                
                Spacer()
                
                Button(action: {
                    dismiss()
                }){
                    Text("Back to profile")
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 400)
                        .background(.blue)
                        .cornerRadius(15)
                }
                
                
            }.padding()
        }
    }
}

struct ProfileUpdatedView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileUpdatedView()
    }
}
