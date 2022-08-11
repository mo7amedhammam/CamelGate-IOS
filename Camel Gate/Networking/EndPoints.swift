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
    
    case GetDriverInfoById = "Driver/GetById"
    case UpdateDriverInfo = "Driver/Update"
    case GetApprovedShipment = "Shipment/GetDriverCurrentApprovedShipment"
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

}
