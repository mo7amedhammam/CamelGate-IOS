//
//  AuthServices.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 02/08/2022.
//

import Foundation
import Moya

enum AuthServices {
    case Login(parameters : [String:Any])
    case createAccount(parameters : [String:Any])

}
extension AuthServices : URLRequestBuilder {
    var path: String {
        switch self {
        case .Login:
            return EndPoints.Login.rawValue
        case .createAccount:
            return EndPoints.CreateAccount.rawValue
        }
    }
    var method: Moya.Method {
        switch self {
        case  .Login  :
            return .post
        case .createAccount:
            return .post
        }
    }
    var sampleData: Data {
        return Data()
    }
    var task: Task {
        switch self {
        case .Login(let param) :
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .createAccount(parameters: let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
}
