//
//  Provider.swift
//  movienow
//
//  Created by Tuan Nguyen Anh on 08/09/2022.
//

import Foundation

// MARK: - WatchProvider
struct WatchProvider: Codable {
    let results: ProviderCoutries?
}

// MARK: - ProviderCoutries
struct ProviderCoutries: Codable {
    let ar, at, au, be: ProviderTypes?
    let br, ca, ch, cl: ProviderTypes?
    let co, cz, de, dk: ProviderTypes?
    let ec, ee, es, fi: ProviderTypes?
    let fr, gb, gr, hu: ProviderTypes?
    let id, ie, countryIN, it: ProviderTypes?
    let jp, kr, lt, lv: ProviderTypes?
    let mx, my, nl, no: ProviderTypes?
    let nz, pe, ph, pl: ProviderTypes?
    let pt: ProviderTypes?
    let ro: ProviderTypesRO?
    let ru, se, sg, th: ProviderTypes?
    let tr, us, ve, za: ProviderTypes?

    enum CodingKeys: String, CodingKey {
        case ar = "AR"
        case at = "AT"
        case au = "AU"
        case be = "BE"
        case br = "BR"
        case ca = "CA"
        case ch = "CH"
        case cl = "CL"
        case co = "CO"
        case cz = "CZ"
        case de = "DE"
        case dk = "DK"
        case ec = "EC"
        case ee = "EE"
        case es = "ES"
        case fi = "FI"
        case fr = "FR"
        case gb = "GB"
        case gr = "GR"
        case hu = "HU"
        case id = "ID"
        case ie = "IE"
        case countryIN = "IN"
        case it = "IT"
        case jp = "JP"
        case kr = "KR"
        case lt = "LT"
        case lv = "LV"
        case mx = "MX"
        case my = "MY"
        case nl = "NL"
        case no = "NO"
        case nz = "NZ"
        case pe = "PE"
        case ph = "PH"
        case pl = "PL"
        case pt = "PT"
        case ro = "RO"
        case ru = "RU"
        case se = "SE"
        case sg = "SG"
        case th = "TH"
        case tr = "TR"
        case us = "US"
        case ve = "VE"
        case za = "ZA"
    }
}

// MARK: - ProviderOffers
// flatrate: subscription services
struct ProviderTypes: Codable {
    let link: String?
    let flatrate, rent, buy: [ProviderDetail]?
}

// MARK: - ProviderOffersRO
struct ProviderTypesRO: Codable {
    let link: String?
    let flatrate: [ProviderDetail]?
}

// MARK: - ProviderOffer
struct ProviderDetail: Codable {
    let displayPriority: Int?
    let logoPath: String?
    let providerID: Int?
    let providerName: String?

    enum CodingKeys: String, CodingKey {
        case displayPriority = "display_priority"
        case logoPath = "logo_path"
        case providerID = "provider_id"
        case providerName = "provider_name"
    }
}
