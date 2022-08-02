//
//  AuthServices.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 02/08/2022.
//

import Foundation
import Moya


enum AuthServices {
//    case Intro
    case Login(parameters : [String:Any])
}
extension AuthServices : URLRequestBuilder {
    var path: String {
        switch self {
//        case .Intro:
//            return EndPoints.Intro.rawValue
        case .Login:
            return EndPoints.Login.rawValue
        }
    }
    var method: Moya.Method {
        switch self {
//        case  .Intro  :
//            return .get
        case  .Login  :
            return .post
      }
    }
    var sampleData: Data {
        return Data()
    }
    var task: Task {
        switch self {
//        case .Intro :
//            return .requestPlain
        case .Login(let param) :
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        }
    }
}
