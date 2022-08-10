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

    case HomeShipmments(parameters : [String:Any])

    case appliedShipMents
    case upComingShipments
    case currentShipments
    
    case ShipmentDetails(parameters : [String:Any])
    case GetCities(parameters:[String:Any])
    case GetShipmentTypes

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
        }
    }
    var method: Moya.Method {
        switch self {

        case .Home , .GetApprovedShipment , .appliedShipMents , .upComingShipments , .currentShipments:
            return .get
        case .HomeShipmments:
            return .post

        case .ShipmentDetails:
            return .get
        case .GetCities:
            return .get
        case .GetShipmentTypes:
            return .get
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
        }
    }
}

