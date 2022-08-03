//
//  SignUpModel.swift
//  Camel Gate
//
//  Created by wecancity on 03/08/2022.
//

import Foundation

struct SignUpModel : Codable{
    let token : String?
    let name : String?
    let image : String?
    let roleId : Int?
    let companyId : Int?
    let statusId : Int?

    enum CodingKeys: String, CodingKey {

        case token = "token"
        case name = "name"
        case image = "image"
        case roleId = "roleId"
        case companyId = "companyId"
        case statusId = "statusId"
    }

}
