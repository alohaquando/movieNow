//
//  ListItem.swift
//  movienow
//
//  Created by Quân Đỗ on 9/18/22.
//

import SwiftUI

struct ProviderListItem: View {
    
    let provider: ProviderDetail
    
    func getImg() -> String {
        return "https://image.tmdb.org/t/p/w500\(provider.logoPath ?? "")"
    }
    
    var body: some View {
        HStack (spacing: 18){
            
            // MARK: Image
            AsyncImage(
                url: URL(string: getImg()),
                content: { image in
                    image
                        .centerCropped()
                        .frame(width: 30, height: 30)
                        .cornerRadius(8)
                },
                placeholder: {
                    ProgressView()
                }
            )
            
            // MARK: Text
            Text(provider.providerName ?? "")
                .foregroundColor(.white)
            Spacer()
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(Color("SurfaceColor"))
        .cornerRadius(10)
    }
}

struct ListItem_Previews: PreviewProvider {
    static let provider = ProviderDetail(displayPriority: 1, logoPath: "/", providerID: 1234, providerName: "Provider name")
    static var previews: some View {
        ProviderListItem(provider: provider)
    }
}
