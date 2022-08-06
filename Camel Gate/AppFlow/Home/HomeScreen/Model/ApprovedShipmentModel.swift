//
//  ApprovedShipmentModel.swift
//  Camel Gate
//
//  Created by wecancity on 06/08/2022.
//

import Foundation

struct ApprovedShipmentModel : Codable {
    let id : Int?
    let code : String?
    let lowestOffer : Int?
    let offersCount : Int?
    let companyRate : Int?
    let companyRatesCount : Int?
    let totalDistance : Int?
    let lowestOfferDriverRate : Int?
    let lowestOfferDriverRatesCount : Int?
    let driverOfferStatusId : Int?
    let driverOfferId : Int?
    let shipmentDateFrom : String?
    let shipmentTimeFrom : ShipmentTimeFrom?
    let shipmentDateTo : String?
    let shipmentTimeTo : ShipmentTimeTo?
    let description : String?
    let fromGovernorateId : Int?
    let fromGovernorateName : String?
    let fromCityId : Int?
    let fromCityName : String?
    let toGovernorateId : Int?
    let toGovernorateName : String?
    let toCity : Int?
    let toCityName : String?
    let fromLat : Int?
    let fromLang : Int?
    let toLat : Int?
    let toLang : Int?
    let shipmentStatusId : Int?
    let shipmentStatusName : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case code = "code"
        case lowestOffer = "lowestOffer"
        case offersCount = "offersCount"
        case companyRate = "companyRate"
        case companyRatesCount = "companyRatesCount"
        case totalDistance = "totalDistance"
        case lowestOfferDriverRate = "lowestOfferDriverRate"
        case lowestOfferDriverRatesCount = "lowestOfferDriverRatesCount"
        case driverOfferStatusId = "driverOfferStatusId"
        case driverOfferId = "driverOfferId"
        case shipmentDateFrom = "shipmentDateFrom"
        case shipmentTimeFrom = "shipmentTimeFrom"
        case shipmentDateTo = "shipmentDateTo"
        case shipmentTimeTo = "shipmentTimeTo"
        case description = "description"
        case fromGovernorateId = "fromGovernorateId"
        case fromGovernorateName = "fromGovernorateName"
        case fromCityId = "fromCityId"
        case fromCityName = "fromCityName"
        case toGovernorateId = "toGovernorateId"
        case toGovernorateName = "toGovernorateName"
        case toCity = "toCity"
        case toCityName = "toCityName"
        case fromLat = "fromLat"
        case fromLang = "fromLang"
        case toLat = "toLat"
        case toLang = "toLang"
        case shipmentStatusId = "shipmentStatusId"
        case shipmentStatusName = "shipmentStatusName"
    }

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        code = try values.decodeIfPresent(String.self, forKey: .code)
//        lowestOffer = try values.decodeIfPresent(Int.self, forKey: .lowestOffer)
//        offersCount = try values.decodeIfPresent(Int.self, forKey: .offersCount)
//        companyRate = try values.decodeIfPresent(Int.self, forKey: .companyRate)
//        companyRatesCount = try values.decodeIfPresent(Int.self, forKey: .companyRatesCount)
//        totalDistance = try values.decodeIfPresent(Int.self, forKey: .totalDistance)
//        lowestOfferDriverRate = try values.decodeIfPresent(Int.self, forKey: .lowestOfferDriverRate)
//        lowestOfferDriverRatesCount = try values.decodeIfPresent(Int.self, forKey: .lowestOfferDriverRatesCount)
//        driverOfferStatusId = try values.decodeIfPresent(Int.self, forKey: .driverOfferStatusId)
//        driverOfferId = try values.decodeIfPresent(Int.self, forKey: .driverOfferId)
//        shipmentDateFrom = try values.decodeIfPresent(String.self, forKey: .shipmentDateFrom)
//        shipmentTimeFrom = try values.decodeIfPresent(ShipmentTimeFrom.self, forKey: .shipmentTimeFrom)
//        shipmentDateTo = try values.decodeIfPresent(String.self, forKey: .shipmentDateTo)
//        shipmentTimeTo = try values.decodeIfPresent(ShipmentTimeTo.self, forKey: .shipmentTimeTo)
//        description = try values.decodeIfPresent(String.self, forKey: .description)
//        fromGovernorateId = try values.decodeIfPresent(Int.self, forKey: .fromGovernorateId)
//        fromGovernorateName = try values.decodeIfPresent(String.self, forKey: .fromGovernorateName)
//        fromCityId = try values.decodeIfPresent(Int.self, forKey: .fromCityId)
//        fromCityName = try values.decodeIfPresent(String.self, forKey: .fromCityName)
//        toGovernorateId = try values.decodeIfPresent(Int.self, forKey: .toGovernorateId)
//        toGovernorateName = try values.decodeIfPresent(String.self, forKey: .toGovernorateName)
//        toCity = try values.decodeIfPresent(Int.self, forKey: .toCity)
//        toCityName = try values.decodeIfPresent(String.self, forKey: .toCityName)
//        fromLat = try values.decodeIfPresent(Int.self, forKey: .fromLat)
//        fromLang = try values.decodeIfPresent(Int.self, forKey: .fromLang)
//        toLat = try values.decodeIfPresent(Int.self, forKey: .toLat)
//        toLang = try values.decodeIfPresent(Int.self, forKey: .toLang)
//        shipmentStatusId = try values.decodeIfPresent(Int.self, forKey: .shipmentStatusId)
//        shipmentStatusName = try values.decodeIfPresent(String.self, forKey: .shipmentStatusName)
//    }

}

struct ShipmentTimeFrom : Codable {
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

struct ShipmentTimeTo : Codable {
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
