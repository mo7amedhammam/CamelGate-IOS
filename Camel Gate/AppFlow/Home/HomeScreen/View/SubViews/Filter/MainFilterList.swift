//
//  MainFilterList.swift
//  Camel Gate
//
//  Created by wecancity on 11/08/2022.
//

import Foundation
import SwiftUI
enum FilterCases{
    case Menu, City, CityFrom, CityTo ,Date , ShipmentTypes
}
struct MainFilterView: View {
    @EnvironmentObject var shipmentVm : ApprovedShipmentViewModel
    @Binding var FilterTag:FilterCases
    @Binding var showFilter:Bool

    var body: some View {
        
        switch FilterTag{
        case .Menu:
            FilterMenu(FilterTag: $FilterTag, showFilter: $showFilter)
                .environmentObject(shipmentVm)
            
        case .City:
            CityFromTo(FilterTag:$FilterTag)
                .environmentObject(shipmentVm)
            
        case .Date:
            DateFromTo(FilterTag: $FilterTag)
                .environmentObject(shipmentVm)
            
        case .ShipmentTypes:
            ShipTypeFilter(FilterTag: $FilterTag)
                .environmentObject(shipmentVm)
            
        case .CityFrom:
            LocationFilter(FilterTag: $FilterTag)
                .environmentObject(shipmentVm)
            
        case .CityTo:
            LocationFilter(FilterTag: $FilterTag)
                .environmentObject(shipmentVm)
            
        }
    }
}
