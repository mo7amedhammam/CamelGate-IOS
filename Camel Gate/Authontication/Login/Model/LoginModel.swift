//
//  LoginModel.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 02/08/2022.
//

import Foundation

struct LoginModel : Codable {
  let success : Int?
  let message_en : String?
  let message_ar : String?
  let token : String?
  let member : Member?


  enum CodingKeys: String, CodingKey {

    case member = "member"
    case token = "token"
    case success = "success"
    case message_en = "message_en"
    case message_ar = "message_ar"
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    member = try values.decodeIfPresent(Member.self, forKey: .member)
    token = try values.decodeIfPresent(String.self, forKey: .token)
    success = try values.decodeIfPresent(Int.self, forKey: .success)
    message_en = try values.decodeIfPresent(String.self, forKey: .message_en)
    message_ar = try values.decodeIfPresent(String.self, forKey: .message_ar)
  }

}
struct Member : Codable {
  let user_id : String?
  let user_name : String?
  let user_phone : String?
  let user_email : String?
  let status : String?
  let m_image : String?
  let user_address : String?
  let city_id : String?
  let city_name_ar : String?
  let city_name_en : String?
  let country_id : String?
  let country_name_ar : String?
  let country_name_en : String?
  let region_id : String?
  let region_name_ar : String?
  let region_name_en : String?

  enum CodingKeys: String, CodingKey {

    case user_id = "user_id"
    case user_name = "user_name"
    case user_phone = "user_phone"
    case user_email = "user_email"
    case status = "status"
    case m_image = "m_image"
    case user_address = "user_address"
    case city_id = "city_id"
    case city_name_ar = "city_name_ar"
    case city_name_en = "city_name_en"
    case country_id = "country_id"
    case country_name_ar = "country_name_ar"
    case country_name_en = "country_name_en"
    case region_id = "region_id"
    case region_name_ar = "region_name_ar"
    case region_name_en = "region_name_en"
  }


}
