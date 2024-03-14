//
//  ProviderViewModel.swift
//  movienow
//
//  Created by Tuan Nguyen Anh on 08/09/2022.
//

import Foundation

struct ProviderVMKeys {
    static let LEADING_URL = "\(TmdbConfigs.BASE_URL)movie/"
    static let TRAILING_URL = "/watch/providers?api_key=\(TmdbConfigs.API_KEY)"
}

class ProviderViewModel: ObservableObject {
    @Published var providers: [ProviderDetail] = [ProviderDetail]()
    
    func getProviders(movieId: Int) {
        let url = "\(ProviderVMKeys.LEADING_URL)\(movieId)\(ProviderVMKeys.TRAILING_URL)"
        
        if let provider = decodeWatchProvider(url: url) {
            if let providerTypes = provider.us {
                self.providers = providerTypes.flatrate ?? [ProviderDetail]()
            }
        }
    }
}
