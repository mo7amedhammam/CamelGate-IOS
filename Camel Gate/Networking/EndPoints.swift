//
//  EndPoints.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 02/08/2022.
//

import Foundation
import SwiftUI

enum EndPoints: String {
    // MARK: - Auth
    case Login = "User/Login"
    case CreateAccount = "User/SignUp"
    case VerifyAccount = "User/VefiryUser"

    case GetDriverInfoById = "Driver/GetById"
    case UpdateDriverInfo = "Driver/Update"
    case GetApprovedShipment = "Shipment/GetDriverCurrentApprovedShipment"
    case startApprovedShipment = "Shipment/StartShipment"
    case UploadApprovedShipment = "Shipment/ShipmentUploaded"
    case FinishApprovedShipment = "Shipment/ShipmentDroppedAndFinished"

    case GetFiltered = "Shipment/GetFiltered"
    
    case appliedShipment = "Shipment/GetDriverAppliedShipments"
    case upcomingShipment = "Shipment/GetDriverUpcomingShipments"
    case currentShipment = "Shipment/GetDriverCurrentShipments"
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

}
