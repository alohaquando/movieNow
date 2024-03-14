//
//  MoviePreferencesView.swift
//  movienow
//
//  Created by Ngan Phan Thi Thu on 31/08/2022.
//

import SwiftUI

struct MoviePreferencesView: View {
    @State private var selectedFrameworkIndex = 0
    var body: some View {
        Form{
            Group{Picker(
                selection: $selectedFrameworkIndex,
                label:Text("SHOW ME")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .opacity(0.6)
                    .padding(.trailing,25)
            ){
                ForEach(0 ..< 9) {item in
                    Text("Action \(item)")
                }
            }
            .pickerStyle(.inline)
            .listRowSeparatorTint(.gray)
            }
            .listRowBackground(Color(red: 0.27, green: 0.27, blue: 0.27))
            
        }
        .foregroundColor(.white)
        .background(Color.black)
        .onAppear { // ADD THESE
            UITableView.appearance().backgroundColor = .clear
        }
        .onDisappear {
            UITableView.appearance().backgroundColor = .systemGroupedBackground
        }
        
        
    }
}

struct MoviePreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviePreferencesView()
    }
}
