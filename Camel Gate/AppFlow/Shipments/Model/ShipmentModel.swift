//
//  ShipmentModel.swift
//  Camel Gate
//
//  Created by wecancity on 07/08/2022.
//

import Foundation
import SwiftUI

// MARK: - Datum
struct FilteredShipmentModel: Codable, Hashable {
    
    static func == (lhs: FilteredShipmentModel, rhs: FilteredShipmentModel) -> Bool {
        lhs.items?.first?.id == rhs.items?.first?.id && lhs.items?.first?.code == rhs.items?.first?.code
    }
    func hash(into hasher: inout Hasher) {
            hasher.combine(items?.first?.id)
            hasher.combine(items?.first?.code)
        }

    var totalCount: Int?
    var items: [ShipmentModel]?
   
    enum CodingKeys: String, CodingKey {
        case totalCount = "totalCount"
        case items = "items"
    }
}


// MARK: - Datum
struct PagedShipmentModel: Codable, Hashable {
    
    static func == (lhs: PagedShipmentModel, rhs: PagedShipmentModel) -> Bool {
        lhs.items?.first?.id == rhs.items?.first?.id && lhs.items?.first?.code == rhs.items?.first?.code
    }
    func hash(into hasher: inout Hasher) {
            hasher.combine(items?.first?.id)
            hasher.combine(items?.first?.code)
        }

    var totalCount: Int?
    var items: [ShipmentModel]?
   
    enum CodingKeys: String, CodingKey {
        case totalCount = "totalCount"
        case items = "items"
    }
}



// MARK: - Datum
struct ShipmentModel: Codable, Hashable, Identifiable {
    static func == (lhs: ShipmentModel, rhs: ShipmentModel) -> Bool {
        lhs.id == rhs.id && lhs.code == rhs.code
    }
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(code)
        }

    var id: Int?
    var code, imageURL: String?
    var estimateTime: String?
    var lowestOffer, offersCount, companyRate, companyRatesCount: Int?
    var totalDistance:Double?
    var lowestOfferDriverRate, lowestOfferDriverRatesCount: Int?
    var driverOfferID, driverOfferValue,driverOfferStatusID: Int?
    var driverOfferStatusName: String?
    var shipmentDateFrom: String?
//    var shipmentTimeFrom: shipmentTimeFrom?
    var shipmentDateTo: String?
//    var shipmentTimeTo: shipmentTimeFrom?
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
        case driverOfferValue, shipmentDateFrom, shipmentDateTo
//        case shipmentTimeFrom, shipmentTimeTo
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


struct shipmentTimeFrom : Codable, Hashable {
    let ticks : Int?
    let days : Int?
    let hours : Int?
    let milliseconds : Int?
    let minutes : Int?
    let seconds : Int?
    let totalDays : Int?
    let totalHours : Int?
    let totalMilliseconds : Int?
    let totalMinutes : Int?
    let totalSeconds : Int?

    enum CodingKeys: String, CodingKey {

        case ticks = "ticks"
        case days = "days"
        case hours = "hours"
        case milliseconds = "milliseconds"
        case minutes = "minutes"
        case seconds = "seconds"
        case totalDays = "totalDays"
        case totalHours = "totalHours"
        case totalMilliseconds = "totalMilliseconds"
        case totalMinutes = "totalMinutes"
        case totalSeconds = "totalSeconds"
    }

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        ticks = try values.decodeIfPresent(Int.self, forKey: .ticks)
//        days = try values.decodeIfPresent(Int.self, forKey: .days)
//        hours = try values.decodeIfPresent(Int.self, forKey: .hours)
//        milliseconds = try values.decodeIfPresent(Int.self, forKey: .milliseconds)
//        minutes = try values.decodeIfPresent(Int.self, forKey: .minutes)
//        seconds = try values.decodeIfPresent(Int.self, forKey: .seconds)
//        totalDays = try values.decodeIfPresent(Int.self, forKey: .totalDays)
//        totalHours = try values.decodeIfPresent(Int.self, forKey: .totalHours)
//        totalMilliseconds = try values.decodeIfPresent(Int.self, forKey: .totalMilliseconds)
//        totalMinutes = try values.decodeIfPresent(Int.self, forKey: .totalMinutes)
//        totalSeconds = try values.decodeIfPresent(Int.self, forKey: .totalSeconds)
//    }

}
