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
    case UpdateDriverInfo(image : UIImage ,parameters : [String:Any])

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
        case .UpdateDriverInfo(image: let image,parameters: let parameters):
            
            let imageData = image.pngData() ?? Data()
//                        let userIdData = parameters.userId.string.data(using: String.Encoding.utf8) ?? Data()
            let imageMultipartFormData = MultipartFormData(provider: .data(imageData), name: "Image", fileName: "user_avatar.jpeg", mimeType: "image/jpeg")
//            let userIdMultipartFormData = MultipartFormData(provider: .data(userIdData), name: "cusId")
            
            return .uploadCompositeMultipart([imageMultipartFormData], urlParameters: parameters)
        }
    }
}
