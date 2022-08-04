//
//  ResponseModel.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 02/08/2022.
//

import Foundation

struct CoreBaseResponse : Codable {
    let message : String?
    let messageCode: Int?
    let success: Bool?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case messageCode = "messageCode"
        case success = "success"
    }
}



struct BaseResponse<T:Codable> : Codable {
    let message: String?
    let messageCode: Int?
    let data: T?
    let success: Bool?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case messageCode = "messageCode"
        case data = "sata"
        case success = "success"
    }
    
    
}