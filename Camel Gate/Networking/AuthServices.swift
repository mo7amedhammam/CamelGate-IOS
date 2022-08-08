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
    case UpdateDriverInfo(parameters : [String:Any] , images : [String : Image?])
    case GetApprovedShipment
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
            
        case .GetApprovedShipment:
            return EndPoints.GetApprovedShipment.rawValue

        }
    }
    var method: Moya.Method {
        switch self {
        case  .Login , .createAccount , .UpdateDriverInfo :
            return .post
        case .GetDriverinfo , .GetApprovedShipment:
            return .get
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
//            var formData = [Moya.MultipartFormData]()
//            // append image to request
//            for (key , image) in images {
//                if let selectedImage = image {
//                    formData.append(Moya.MultipartFormData(provider: .data(selectedImage.fixOrientation().jpegData(.lowest)!), name: "\(key)", fileName: "Image_\(Int(Date().timeIntervalSince1970))"+".jpeg", mimeType: "image/jpeg"))
//                }
//            }
//            // append parameters to request
//            for (key, value) in param {
//                formData.append(Moya.MultipartFormData(provider: .data((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!), name: key))
//            }
            
            var formData = [Moya.MultipartFormData]()
            //                          append image to request
            for (key , image) in images {
                if let selectedImage = image,image?.size.width ?? 0 > 0 {
                    formData.append(Moya.MultipartFormData(provider: .data(selectedImage.fixOrientation().jpegData(.lowest)!), name: "\(key)", fileName: "image_\(Int(Date().timeIntervalSince1970))"+".jpeg", mimeType: "image/jpeg"))
                }else{
                    print("no image")
                }
            }
            // append parameters to request
            for (key, value) in param {

                if let temp = value as? String {
                    formData.append(Moya.MultipartFormData(provider: .data(temp.data(using: .utf8)!), name: key))
                }
                if let temp = value as? Int {
                    formData.append(Moya.MultipartFormData(provider: .data("\(temp)".data(using: .utf8)!), name: key))
                }
                if let temp = value as? NSArray{
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            formData.append(Moya.MultipartFormData(provider: .data(string.data(using: .utf8)!), name: keyObj))
                        } else
                        if let num = element as? Int {
                            let value = "\(num)"
                            formData.append(Moya.MultipartFormData(provider: .data(value.data(using: .utf8)!), name: keyObj))
                        }
                    })
                }
            }
            return .uploadMultipart(formData)
        case .GetApprovedShipment:
            return .requestPlain
        }
    }
}
