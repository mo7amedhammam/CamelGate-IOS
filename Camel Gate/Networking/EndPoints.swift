//
//  EndPoints.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 02/08/2022.
//

import Foundation

enum EndPoints: String {
    // MARK: - Auth
    case Login = "User/Login"
    case CreateAccount = "User/SignUp"
    case VerifyUser = "User/VefiryUser"
    case resendOTP = "User/SendOTP"
    
    case CanDeleteAccount = "Lookups/GetSetting"
    case DeleteAccount = "User/RemoveAccount"

    case GetDriverOverallRate = "ShipmentRate/GetDriverOverallRate"
    case GetDriverRates = "ShipmentRate/GetDriverRates"
    case GetDriverInfoById = "Driver/GetById"
    case UpdateDriverInfo = "Driver/Update"
    case GetApprovedShipment = "Shipment/GetDriverCurrentApprovedShipment"
    case startApprovedShipment = "Shipment/StartShipment"
    case UploadApprovedShipment = "Shipment/ShipmentUploaded"
    case FinishApprovedShipment = "Shipment/ShipmentDroppedAndFinished"
    case RateApprovedShipment = "ShipmentRate/Rate"

    case GetFiltered = "Shipment/GetPagedFiltered"
    
    case appliedShipment = "Shipment/GetDriverPagedAppliedShipments"
    case upcomingShipment = "Shipment/GetDriverPagedUpcomingShipments"
    case currentShipment = "Shipment/GetDriverPagedCurrentShipments"
    case ShipmentDetails = "Shipment/GetShipment"
    case GetCities = "City/Get"
    case GetShipmentTypes = "ShipmentType/GetAllForList"
    case SetOffer = "Shipment/SetOffer"
    case CancelOffer = "Shipment/CancelOffer"
    case CancelationReasons = "ShipmentCancelationReason/GetAllForList"
    case GetTruckTypes = "TruckType/GetAllForList"
    case GetTruckManfacture = "TruckManfacture/GetAllForList"
    case getNationalities = "Nationality/GetAllForList"
    case ChangePassword = "User/ChangePassword"
    case ChangeForgetPassword = "User/ResetPassword"
    case VerifyOtp = "User/VefiryOTP"
    case GetGaiedWallet = "Wallet/GetWalletGained"
    case GetWithDrawnWallet = "Wallet/GetWalletWithdrawn"
    case GetHomePageWallet = "Wallet/GetHomePageWallet"
    
    case FirebaseNotifications = "User/UpdateFirebaseDeviceToken"
    case removeFirebaseNotifications = "User/RemoveFirebaseDeviceToken"

    
}
