//
//  rateModel.swift
//  Camel Gate
//
//  Created by wecancity on 27/11/2022.
//

import Foundation

struct  rateModel : Codable{
    var id, shipmentOfferId, rate: Int?
    var isDriver: Bool?
    var creationdate: String?
    var createdBy: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case shipmentOfferId = "shipmentOfferId"
        case rate = "rate"
        case isDriver = "isDriver"
        case creationdate = "creationdate"
        case createdBy = "createdBy"

    }
}
