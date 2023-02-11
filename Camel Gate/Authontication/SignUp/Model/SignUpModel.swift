//
//  SignUpModel.swift
//  Camel Gate
//
//  Created by wecancity on 03/08/2022.
//

import Foundation

struct SignUpPhoneVerify:Codable{
    let otp, secondsCount : Int?
}

struct SignUpModel : Codable{
    let token : String?
    let name : String?
    let image : String?
    let roleId : Int?
    let companyId : Int?
    let statusId : Int?
    let profileStatusId :Int?
//    let isDriverInCompany : Bool?

    enum CodingKeys: String, CodingKey {
        case token = "token"
        case name = "name"
        case image = "image"
        case roleId = "roleId"
        case companyId = "companyId"
        case statusId = "statusId"
        case profileStatusId = "profileStatusId"
//        case isDriverInCompany = "isDriverInCompany"
    }
}



struct NotificationModel:Codable{
    let title, description : String?
}
