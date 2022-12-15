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
        
//        ZStack(alignment: .bottom) {
//            if (showFilter) {
//                Color.black
//                    .opacity(0.3)
//                    .ignoresSafeArea()
//                    .onTapGesture {
//                        showFilter.toggle()
//                    }
//
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
            
//                .padding(.bottom, 42)
//                .transition(.move(edge: .bottom))
//                .background(
//                    Color(uiColor: .white)
//                )
//                .cornerRadius(radius: 16, corners: [.topLeft, .topRight])
//        }
        }
//    }
//                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
//                .ignoresSafeArea()
//                .animation(.easeInOut, value: showFilter)
}
}



struct MainFilterView_Previews: PreviewProvider {
    static var previews: some View {
        MainFilterView(FilterTag: .constant(.Menu), showFilter: .constant(true))
            .environmentObject(ApprovedShipmentViewModel())
        
    }
}

//struct BottomSheet: View {
//
//    @Binding var isShowing: Bool
//    var content: AnyView
//
//    var body: some View {
//        ZStack(alignment: .bottom) {
//            if (isShowing) {
//                Color.black
//                    .opacity(0.3)
//                    .ignoresSafeArea()
//                    .onTapGesture {
//                        isShowing.toggle()
//                    }
//                content
//                    .padding(.bottom, 42)
//                    .transition(.move(edge: .bottom))
//                    .background(
//                        Color(uiColor: .white)
//                    )
//                    .cornerRadius(radius: 16, corners: [.topLeft, .topRight])
//            }
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
//        .ignoresSafeArea()
//        .animation(.easeInOut, value: isShowing)
//    }
//}
