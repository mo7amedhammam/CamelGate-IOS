//
//  DriverRateModel.swift
//  Camel Gate
//
//  Created by wecancity on 08/12/2022.
//

import Foundation

struct DriverRateModel:Codable{
    let ratesCount : Int?
    let rate : Double?
    
    
    enum CodingKeys: String, CodingKey {
        case rate = "rate"
        case ratesCount = "ratesCount"
    }
}
