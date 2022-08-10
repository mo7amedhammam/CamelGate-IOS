//
//  CityModel.swift
//  Camel Gate
//
//  Created by wecancity on 10/08/2022.
//

import Foundation

// MARK: - CityModel
struct CityModel: Codable , Hashable, Identifiable{
    var id: Int?
    var governorateTitle, title, titleAr: String?
    var governorateID: Int?
    var lat, lang: Double?
    var order: Int?

    enum CodingKeys: String, CodingKey {
        case id, governorateTitle, title, titleAr
        case governorateID = "governorateId"
        case lat, lang, order
    }
}
