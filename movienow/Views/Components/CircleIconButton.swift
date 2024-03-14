//
//  CircleIconButton.swift
//  movienow
//
//  Created by Quân Đỗ on 9/18/22.
//

import SwiftUI

struct CircleIconButton: View {
    var iconName: String
    var body: some View {
        ZStack{
            Circle().foregroundColor(.black).opacity(0.5)
            Image(systemName: iconName).resizable().scaledToFit().padding(12)
        }.frame(width: 40)
    }
}

struct CircleIconButton_Previews: PreviewProvider {
    static var previews: some View {
        CircleIconButton(iconName: "magnifyingglass")
    }
}
