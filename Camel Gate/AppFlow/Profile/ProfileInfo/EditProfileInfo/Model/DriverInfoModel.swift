//
//  DriverInfoModel.swift
//  Camel Gate
//
//  Created by wecancity on 04/08/2022.
//

import Foundation
import SwiftUI

struct DriverInfoModel : Codable {
    let drivingLicenseExpirationDate : String?
    let id : Int?
    let name : String?
    let mobile : String?
    let creationDate : String?
    let passwordHash : String?
    let drivingLicense : String?
    let email : String?
    let image : String?
    let birthdate : String?
    let nationalityName : String?
    let nationalityId : Int?
    let gender : Int?
    let statusId : Int?
    let citizenId,residentId,borderId : String?

    let truckInfo : TruckInfo?

    enum CodingKeys: String, CodingKey {

        case drivingLicenseExpirationDate = "drivingLicenseExpirationDate"
        case id = "id"
        case name = "name"
        case mobile = "mobile"
        case creationDate = "creationDate"
        case passwordHash = "passwordHash"
        case drivingLicense = "drivingLicense"
        case email = "email"
        case image = "image"
        case birthdate = "birthdate"
        case gender = "gender"
        case statusId = "statusId"
        case truckInfo = "truckInfo"
        case nationalityName = "nationalityName"
        case nationalityId = "nationalityId"
        case citizenId = "citizenId"
        case residentId = "residentId"
        case borderId = "borderId"
    }

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        drivingLicenseExpirationDate = try values.decodeIfPresent(String.self, forKey: .drivingLicenseExpirationDate)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
//        creationDate = try values.decodeIfPresent(String.self, forKey: .creationDate)
//        passwordHash = try values.decodeIfPresent(String.self, forKey: .passwordHash)
//        drivingLicense = try values.decodeIfPresent(String.self, forKey: .drivingLicense)
//        email = try values.decodeIfPresent(String.self, forKey: .email)
//        image = try values.decodeIfPresent(String.self, forKey: .image)
//        birthdate = try values.decodeIfPresent(String.self, forKey: .birthdate)
//        gender = try values.decodeIfPresent(Int.self, forKey: .gender)
//        statusId = try values.decodeIfPresent(Int.self, forKey: .statusId)
//        truckInfo = try values.decodeIfPresent(TruckInfo.self, forKey: .truckInfo)
//    }

}

struct TruckInfo : Codable {
    let plate : String?
    let license : Int?
    let licenseIssueDate : String?
    let licenseExpirationDate : String?
    let numberofAxe : Int?
    let truckTypeId : Int?
    let truckManufacturerId : Int?
    let id : Int?
    let imageUrl : String?
    let creationdate : String?
    let productionYear : Int?
    let camelGateCode : String?

    enum CodingKeys: String, CodingKey {
        case plate = "plate"
        case license = "license"
        case licenseIssueDate = "licenseIssueDate"
        case licenseExpirationDate = "licenseExpirationDate"
        case numberofAxe = "numberofAxe"
        case truckTypeId = "truckTypeId"
        case truckManufacturerId = "truckManufacturerId"
        case id = "id"
        case imageUrl = "imageUrl"
        case creationdate = "creationdate"
        case productionYear = "productionYear"
        case camelGateCode = "camelGateCode"
    }

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        plate = try values.decodeIfPresent(Int.self, forKey: .plate)
//        license = try values.decodeIfPresent(Int.self, forKey: .license)
//        licenseIssueDate = try values.decodeIfPresent(String.self, forKey: .licenseIssueDate)
//        licenseExpirationDate = try values.decodeIfPresent(String.self, forKey: .licenseExpirationDate)
//        numberofAxe = try values.decodeIfPresent(Int.self, forKey: .numberofAxe)
//        truckTypeId = try values.decodeIfPresent(Int.self, forKey: .truckTypeId)
//        truckManufacturerId = try values.decodeIfPresent(Int.self, forKey: .truckManufacturerId)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
//        creationdate = try values.decodeIfPresent(String.self, forKey: .creationdate)
//    }

}
