//
//  MovieInfoBar.swift
//  movienow
//
//  Created by Quân Đỗ on 9/18/22.
//

import SwiftUI

struct MovieInfoBar: View {
    let voteAverage: Double
    let tag1: String
//    let tag2: String?
//    let tag3: String?
    
    var body: some View {
        VStack(spacing: 8){
            HStack {
                // MARK: Star rating
                if (voteAverage / 2 != 0.0) {
                    Text(String(voteAverage / 2))
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.semibold)
                } else {
                    Text("No rating")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.semibold)
                }
                Image(systemName: "star.fill")
                
                Spacer()
                    .frame(width: 16)
                
                // MARK: Tags
                Text("Released in " + tag1.prefix(4))
                    .font(.callout)
//                Text("•")
//                Text(tag2 ?? "")
//                    .font(.caption)
//                Text("•")
//                Text(tag3 ?? "")
//                    .font(.caption)
                
                Spacer()
            }
            Divider()
        }
    }
}

struct MovieInfoBar_Previews: PreviewProvider {
    static var previews: some View {
        MovieInfoBar(voteAverage: 4.8, tag1: "2022")
    }
}
