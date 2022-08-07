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
    case appliedShipment = "Shipment/GetDriverAppliedShipments"
    case upcomingShipment = "Shipment/GetDriverUpcomingShipments"
    case currentShipment = "Shipment/GetDriverCurrentShipments"

}
