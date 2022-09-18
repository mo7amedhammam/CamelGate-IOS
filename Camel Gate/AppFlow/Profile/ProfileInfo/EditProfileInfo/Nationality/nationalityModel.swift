//
//  nationalityModel.swift
//  Camel Gate
//
//  Created by wecancity on 18/09/2022.
//

import Foundation

// MARK: - CityModel
struct nationalityModel: Codable , Hashable, Identifiable{
    var id: Int?
    var  title: String?

    enum CodingKeys: String, CodingKey {
        case id, title
    }
}

