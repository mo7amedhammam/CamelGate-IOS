//
//  ShipmentModel.swift
//  Camel Gate
//
//  Created by wecancity on 07/08/2022.
//

import Foundation

// MARK: - Datum
struct ShipmentModel: Codable, Hashable, Identifiable {
    
        var id: Int?
        var code, imageURL: String?
        var estimateTime: String?
        var lowestOffer, offersCount, companyRate, companyRatesCount: Int?
        var totalDistance: Double?
        var lowestOfferDriverRate, lowestOfferDriverRatesCount, driverOfferStatusID: Int?
        var driverOfferStatusName: String?
        var driverOfferID, driverOfferValue: Int?
        var shipmentDateFrom, shipmentTimeFrom, shipmentDateTo, shipmentTimeTo: String?
        var description: String?
        var fromGovernorateID: Int?
        var fromGovernorateName: String?
        var fromCityID: Int?
        var fromCityName: String?
        var toGovernorateID: Int?
        var toGovernorateName: String?
        var toCity: Int?
        var toCityName: String?
        var fromLat, fromLang, toLat, toLang: Double?
        var shipmentStatusID: Int?
        var shipmentStatusName: String?

        enum CodingKeys: String, CodingKey {
            case id, code
            case imageURL = "imageUrl"
            case estimateTime, lowestOffer, offersCount, companyRate, companyRatesCount, totalDistance, lowestOfferDriverRate, lowestOfferDriverRatesCount
            case driverOfferStatusID = "driverOfferStatusId"
            case driverOfferStatusName
            case driverOfferID = "driverOfferId"
            case driverOfferValue, shipmentDateFrom, shipmentTimeFrom, shipmentDateTo, shipmentTimeTo
            case description = "description"
            case fromGovernorateID = "fromGovernorateId"
            case fromGovernorateName
            case fromCityID = "fromCityId"
            case fromCityName
            case toGovernorateID = "toGovernorateId"
            case toGovernorateName, toCity, toCityName, fromLat, fromLang, toLat, toLang
            case shipmentStatusID = "shipmentStatusId"
            case shipmentStatusName
        }
}

