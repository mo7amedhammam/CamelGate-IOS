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
    case RateApprovedShipment(parameters:[String:Any])

    case HomeShipmments(parameters : [String:Any])

    case appliedShipMents(parameters : [String:Any])
    case upComingShipments(parameters : [String:Any])
    case currentShipments(parameters : [String:Any])
    
    case ShipmentDetails(parameters : [String:Any])
    case GetCities
    case GetShipmentTypes

    case setOffer(parameters:[String:Any])
    case CancelOffer(parameters:[String:Any])
    case CancelationReasons
    
    case ChangePassword(parameters:[String:Any])
    case ChangeForgetPassword(parameters:[String:Any])
    case VerifyOtp(parameters : [String:Any])

    case getGainedWallet
    case getWithdrawnWallet
    case getHomePageWallet
    case sendFirebaseToken(parameters:[String:Any])
    case removeFirebaseToken
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
        case .RateApprovedShipment:
            return EndPoints.RateApprovedShipment.rawValue

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
        case .ChangeForgetPassword:
            return EndPoints.ChangeForgetPassword.rawValue
        case .VerifyOtp:
            return EndPoints.VerifyOtp.rawValue

        case .getGainedWallet:
            return EndPoints.GetGaiedWallet.rawValue
        case .getWithdrawnWallet:
            return EndPoints.GetWithDrawnWallet.rawValue
        case .getHomePageWallet:
            return EndPoints.GetHomePageWallet.rawValue
        
        case .sendFirebaseToken:
            return EndPoints.FirebaseNotifications.rawValue
        case .removeFirebaseToken:
            return EndPoints.removeFirebaseNotifications.rawValue
        }
    }
    var method: Moya.Method {
        switch self {
        case .Home,
                .GetApprovedShipment,
                .StartApprovedShipment,
                .UploadApprovedShipment,
                .FinishApprovedShipment,
                .getGainedWallet,
                .getWithdrawnWallet,
                .getHomePageWallet,
                .ShipmentDetails,
                .GetShipmentTypes,
                .GetCities,
                .CancelationReasons,
                .removeFirebaseToken:
            return .get
            
        case .HomeShipmments, .appliedShipMents, .upComingShipments, .currentShipments, .RateApprovedShipment,.setOffer,.CancelOffer,.ChangePassword, .ChangeForgetPassword, .sendFirebaseToken, .VerifyOtp:
            return .post   
        }
    }
    var sampleData: Data {
        return Data()
    }
    var task: Task {
        switch self {
        case .Home,
                .GetApprovedShipment,
                .getGainedWallet,
                .getWithdrawnWallet,
                .getHomePageWallet,
                .CancelationReasons,
                .GetShipmentTypes,
                .GetCities,
                .removeFirebaseToken:
            return .requestPlain
      
        case .HomeShipmments(let param),
                .appliedShipMents(let param),
                .upComingShipments(let param),
                .currentShipments(let param),
                .setOffer( let param),
                .CancelOffer( let param),
                .ChangePassword(parameters: let param),
                .ChangeForgetPassword(parameters: let param),
                .RateApprovedShipment(parameters: let param),
                .VerifyOtp(parameters: let param):
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)

        case .ShipmentDetails(let param),
                .StartApprovedShipment(let param),
                .UploadApprovedShipment(let param),
                .FinishApprovedShipment(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)

        case .sendFirebaseToken(let param):
            return .requestCompositeData(bodyData: sampleData, urlParameters: param)
        }
    }
}

