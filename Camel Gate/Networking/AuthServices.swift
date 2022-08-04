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
    case GetDriverinfo
    case UpdateDriverInfo(images : [String : Image?] ,parameters : [String:Any])

}
extension AuthServices : URLRequestBuilder {
    var path: String {
        switch self {
        case .Login:
            return EndPoints.Login.rawValue
        case .createAccount:
            return EndPoints.CreateAccount.rawValue
        case .GetDriverinfo:
            return EndPoints.GetDriverInfoById.rawValue
        case .UpdateDriverInfo:
            return EndPoints.UpdateDriverInfo.rawValue

        }
    }
    var method: Moya.Method {
        switch self {
        case  .Login  :
            return .post
        case .createAccount:
            return .post
        case .GetDriverinfo:
            return .get
        case .UpdateDriverInfo:
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
        case .GetDriverinfo:
            return .requestPlain
        case .UpdateDriverInfo(let param,let images):
            
            var formData = [Moya.MultipartFormData]()
                         // append image to request
                         for (key , image) in images {
                             if let selectedImage = image {
                                 formData.append(Moya.MultipartFormData(provider: .data(selectedImage.fixOrientation().jpegData(.lowest)!), name: "\(key)", fileName: "image_\(Int(Date().timeIntervalSince1970))"+".jpeg", mimeType: "image/jpeg"))
                             }
                         }
                         // append parameters to request
                         for (key, value) in param {
                             formData.append(Moya.MultipartFormData(provider: .data((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!), name: key))
                         }
                     return .uploadMultipart(formData)
        }
    }
}
