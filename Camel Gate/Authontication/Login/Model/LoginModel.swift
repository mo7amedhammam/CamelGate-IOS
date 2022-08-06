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
    let profileStatusId :Int?

    enum CodingKeys: String, CodingKey {
        case token = "token"
        case name = "name"
        case image = "image"
        case roleId = "roleId"
        case companyId = "companyId"
        case statusId = "statusId"
        case profileStatusId = "profileStatusId"
        
    }
}
