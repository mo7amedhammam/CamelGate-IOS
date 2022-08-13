//
//  TruckTypeModel.swift
//  Camel Gate
//
//  Created by wecancity on 13/08/2022.
//

import Foundation

// MARK: - CityModel
struct TruckTypeModel: Codable , Hashable, Identifiable{
    var id: Int?
    var  title: String?

    enum CodingKeys: String, CodingKey {
        case id, title
    }
}

