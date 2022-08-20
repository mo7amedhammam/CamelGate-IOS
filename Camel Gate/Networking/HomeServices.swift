//
//  HomeServices.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 8/6/22.
//

import Foundation
import Moya
import SwiftUI

enum HomeServices {
    
    case Home
    case GetApprovedShipment
    case StartApprovedShipment(parameters : [String:Any])
    case UploadApprovedShipment(parameters : [String:Any])
    case FinishApprovedShipment(parameters : [String:Any])

    case HomeShipmments(parameters : [String:Any])

    case appliedShipMents
    case upComingShipments
    case currentShipments
    
    case ShipmentDetails(parameters : [String:Any])
    case GetCities(parameters:[String:Any])
    case GetShipmentTypes

    case setOffer(parameters:[String:Any])
    case CancelOffer(parameters:[String:Any])
    case CancelationReasons
    
    case ChangePassword(parameters:[String:Any])

}
extension HomeServices : URLRequestBuilder {
    var path: String {
        switch self {
        case .Home:
            return EndPoints.Login.rawValue
        case .HomeShipmments:
            return EndPoints.GetFiltered.rawValue
        case .GetApprovedShipment:
            return EndPoints.GetApprovedShipment.rawValue

        case .appliedShipMents :
            return EndPoints.appliedShipment.rawValue
        case .upComingShipments :
            return EndPoints.upcomingShipment.rawValue
        case .currentShipments :
            return EndPoints.currentShipment.rawValue
            
        case .ShipmentDetails:
            return EndPoints.ShipmentDetails.rawValue
        case .GetCities:
            return EndPoints.GetCities.rawValue
            
        case .GetShipmentTypes:
            return EndPoints.GetShipmentTypes.rawValue
        case .setOffer:
            return EndPoints.SetOffer.rawValue
        case .CancelOffer:
            return EndPoints.CancelOffer.rawValue
        case .CancelationReasons:
            return EndPoints.CancelationReasons.rawValue
        case .StartApprovedShipment:
            return EndPoints.startApprovedShipment.rawValue

        case .UploadApprovedShipment:
            return EndPoints.UploadApprovedShipment.rawValue

        case .FinishApprovedShipment:
            return EndPoints.FinishApprovedShipment.rawValue

        case .ChangePassword:
            return EndPoints.ChangePassword.rawValue

        }
    }
    var method: Moya.Method {
        switch self {

        case .Home , .GetApprovedShipment, .StartApprovedShipment, .UploadApprovedShipment, .FinishApprovedShipment , .appliedShipMents , .upComingShipments , .currentShipments:
            return .get
        case .HomeShipmments:
            return .post

        case .ShipmentDetails, .GetShipmentTypes, .GetCities, .CancelationReasons:
            return .get
   
        case .setOffer,.CancelOffer,.ChangePassword:
            return .post
        }
    }
    var sampleData: Data {
        return Data()
    }
    var task: Task {
        switch self {
        case .Home , .appliedShipMents , .upComingShipments , .currentShipments:
            return .requestPlain
        case .HomeShipmments(let param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .GetApprovedShipment:
            return .requestPlain
    
        case .ShipmentDetails(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .GetCities(parameters: let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .GetShipmentTypes:
            return .requestPlain
        case .setOffer( let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .CancelOffer( let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)

        case .CancelationReasons:
            return .requestPlain
        case .StartApprovedShipment(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)

        case .UploadApprovedShipment(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)

        case .FinishApprovedShipment(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)

        case .ChangePassword(parameters: let param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)

        }
    }
}

