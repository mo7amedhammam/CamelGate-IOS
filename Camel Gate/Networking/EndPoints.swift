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
    case VerifyAccount = "User/VefiryUser"
    case resendOTP = "User/SendOTP"

    case GetDriverRate = "ShipmentRate/GetDriverOverallRate"
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
    case ChangeForgetPassword = "User/ChangeForgetPassword"
    case GetGaiedWallet = "Wallet/GetWalletGained"
    case GetWithDrawnWallet = "Wallet/GetWalletWithdrawn"
    case GetHomePageWallet = "Wallet/GetHomePageWallet"
}
