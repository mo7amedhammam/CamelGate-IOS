//
//  ResponseModel.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 02/08/2022.
//

import Foundation

struct ResponseModel : Codable {
  let status : Int?
  let message : String?


  enum CodingKeys: String, CodingKey {

    case status = "status"
    case message = "message"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    status = try values.decodeIfPresent(Int.self, forKey: .status)
    message = try values.decodeIfPresent(String.self, forKey: .message)
  }

}
