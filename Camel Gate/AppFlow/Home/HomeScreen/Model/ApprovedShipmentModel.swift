//
//  ApprovedShipmentModel.swift
//  Camel Gate
//
//  Created by wecancity on 06/08/2022.
//

import Foundation
import SwiftUI

struct ApprovedShipmentModel : Codable, Hashable, Identifiable {
    static func == (lhs: ApprovedShipmentModel, rhs: ApprovedShipmentModel) -> Bool {
        lhs.id == rhs.id
    }
        var id: Int?
        var code, imageURL: String?
        var estimateTime: String?
        var lowestOffer, offersCount, companyRatesCount: Int?
        var companyRate, lowestOfferDriverRate: Double?
        var lowestOfferDriverRatesCount, driverOfferStatusID: Int?
        var totalDistance:Double?
        var driverOfferStatusName: String?
        var driverOfferID, driverOfferValue: Int?
        var shipmentDateFrom: String?
//        var shipmentTimeFrom: [String: Int]?
        var shipmentDateTo: String?
//        var shipmentTimeTo: [String: Int]?
        var approvedShipmentModelDescription: String?
        var fromGovernorateID: Int?
        var fromGovernorateName: String?
        var fromCityID: Int?
        var fromCityName: String?
        var toGovernorateID: Int?
        var toGovernorateName: String?
        var toCity: Int?
        var toCityName: String?
        var fromLat, fromLang, toLat, toLang: Double?
        var shipmentStatusId: Int?
        var shipmentStatusName: String?

        enum CodingKeys: String, CodingKey {
            case id, code
            case imageURL = "imageUrl"
            case estimateTime, lowestOffer, offersCount, companyRate, companyRatesCount, totalDistance, lowestOfferDriverRate, lowestOfferDriverRatesCount
            case driverOfferStatusID = "driverOfferStatusId"
            case driverOfferStatusName
            case driverOfferID = "driverOfferId"
            case driverOfferValue, shipmentDateFrom, shipmentDateTo
            case approvedShipmentModelDescription = "description"
//            case shipmentTimeFrom, shipmentTimeTo
            case fromGovernorateID = "fromGovernorateId"
            case fromGovernorateName
            case fromCityID = "fromCityId"
            case fromCityName
            case toGovernorateID = "toGovernorateId"
            case toGovernorateName, toCity, toCityName, fromLat, fromLang, toLat, toLang
            case shipmentStatusId = "shipmentStatusId"
            case shipmentStatusName
        }
    }


// MARK: - SetOfferModel
struct SetOfferModel: Codable {
    var driverId, shipmentID, shipmentOfferId, truckTypeId: Int?
    var driverName: String?
    var driverOfferValue: Int?
    var truckTypeName: String?

    enum CodingKeys: String, CodingKey {
        case shipmentID = "shipmentId"
        case driverName,driverId , driverOfferValue,shipmentOfferId, truckTypeId, truckTypeName
    }
}

// MARK: - CancelOfferModel
struct CancelOfferModel: Codable {
    var shipmentOfferId, shipmentID, driverId, truckTypeId: Int?
    var driverName: String?
    var driverOfferValue: Int?
    var truckTypeName: String?

    enum CodingKeys: String, CodingKey {
        case shipmentOfferId
        case shipmentID = "shipmentId"
        case driverName, driverId, driverOfferValue, truckTypeId, truckTypeName
    }
}
