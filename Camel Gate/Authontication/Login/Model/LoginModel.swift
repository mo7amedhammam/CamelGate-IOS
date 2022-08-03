//
//  LoginModel.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 02/08/2022.
//

import Foundation

struct LoginModel : Codable{
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

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        token = try values.decodeIfPresent(String.self, forKey: .token)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        image = try values.decodeIfPresent(String.self, forKey: .image)
//        roleId = try values.decodeIfPresent(Int.self, forKey: .roleId)
//        companyId = try values.decodeIfPresent(Int.self, forKey: .companyId)
//        statusId = try values.decodeIfPresent(Int.self, forKey: .statusId)
//    }

}
