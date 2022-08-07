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
    case appliedShipMents
    case upComingShipments
    case currentShipments
    
}
extension HomeServices : URLRequestBuilder {
    var path: String {
        switch self {
        case .Home:
            return EndPoints.Login.rawValue
        case .appliedShipMents :
            return EndPoints.appliedShipment.rawValue
        case .upComingShipments :
            return EndPoints.upcomingShipment.rawValue
        case .currentShipments :
            return EndPoints.currentShipment.rawValue
       
            
        }
    }
    var method: Moya.Method {
        switch self {
//        case  .Login , .createAccount , .UpdateDriverInfo :
//            return .post
        case .Home , .appliedShipMents , .upComingShipments , .currentShipments:
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
    
        }
    }
}

