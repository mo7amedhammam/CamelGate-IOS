//
//  HomeServices.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 8/6/22.
//

import Foundation
import Moya

enum HomeServices {
    
    case Home
    case GetApprovedShipment

    case HomeShipmments(parameters : [String:Any])

    case appliedShipMents
    case upComingShipments
    case currentShipments
    
    case ShipmentDetails(parameters : [String:Any])

    
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
        }
    }
    var method: Moya.Method {
        switch self {
//        case  .Login , .createAccount , .UpdateDriverInfo :
//            return .post
            
        case .Home , .GetApprovedShipment , .appliedShipMents , .upComingShipments , .currentShipments:
            return .get
        case .HomeShipmments:
            return .post

        case .ShipmentDetails:
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
        }
    }
}

