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
    var code: String?
    var lowestOffer, offersCount, companyRate, companyRatesCount: Int?
    var totalDistance: Double?
    var lowestOfferDriverRate, lowestOfferDriverRatesCount, driverOfferStatusID, driverOfferID: Int?
    var shipmentDateFrom, shipmentTimeFrom, shipmentDateTo, shipmentTimeTo: String?
    var datumDescription: String?
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
        case id, code, lowestOffer, offersCount, companyRate, companyRatesCount, totalDistance, lowestOfferDriverRate, lowestOfferDriverRatesCount
        case driverOfferStatusID = "driverOfferStatusId"
        case driverOfferID = "driverOfferId"
        case shipmentDateFrom, shipmentTimeFrom, shipmentDateTo, shipmentTimeTo
        case datumDescription = "description"
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
