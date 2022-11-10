//
//  WalletModel.swift
//  Camel Gate
//
//  Created by wecancity on 07/11/2022.
//

import Foundation

// MARK: - ChangePasswordModel
struct WalletModel: Codable {
    var currentBalance:Int?
    var gainedBalance: Int?
    var shipmentPayments: [ShipmentPayment]?
    
    enum CodingKeys: String, CodingKey {
        case currentBalance = "currentBalance"
        case gainedBalance = "gainedBalance"
        case shipmentPayments = "shipmentPayments"
    }
}

// MARK: - ShipmentPayment
struct ShipmentPayment: Codable, Identifiable, Hashable {
    var gainedValue, offerValue, cadminValue, id: Int?
    var date: String?

    enum CodingKeys: String, CodingKey {
        case gainedValue = "gainedValue"
        case offerValue = "offerValue"
        case cadminValue = "cadminValue"
        case id = "shipmentId"
        case date = "date"
    }
}
