//
//  DriverRatesModel.swift
//  Camel Gate
//
//  Created by wecancity on 18/12/2022.
//

import Foundation

struct DriverRatesModel:Codable, Hashable,Identifiable{
    
    let id : Int?
    let rate : Double?
    let shipmentCode, date : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "shipmentId"
        case rate = "rate"
        case shipmentCode = "shipmentCode"
        case date = "date"
    }
}
