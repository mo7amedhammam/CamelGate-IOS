//
//  ShipTypeModel.swift
//  Camel Gate
//
//  Created by wecancity on 11/08/2022.
//

import Foundation

// MARK: - CityModel
struct ShipTypeModel: Codable , Hashable, Identifiable{
    var id: Int?
    var  title: String?

    enum CodingKeys: String, CodingKey {
        case id, title
    }
}
