//
//  GarageView.swift
//  Camel Gate
//
//  Created by wecancity on 21/07/2022.
//

import SwiftUI

struct GarageView: View {
    var language = LocalizationService.shared.language

    @EnvironmentObject var ApprovedShipmentVM : ApprovedShipmentViewModel

    @State var active = false
    @State var destination = AnyView(DetailsView(shipmentId: 0))
    
    @Binding var FilterTag : FilterCases
    @Binding var showFilter:Bool
    @State var selectedShipmentId = 0

    var body: some View {
        ZStack{
            ExtractedView(active: $active, destination: $destination, selectedShipmentId: $selectedShipmentId)
                .environmentObject(ApprovedShipmentVM)
                .padding(.top,140)
                .padding(.horizontal,10)

            
            TitleBar(Title: "Garage_Shipments".localized(language), navBarHidden: true, trailingButton: .filterButton, applyStatus: Optional.none, trailingAction: {
                showFilter.toggle()
            })
        }
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

        .onAppear(perform: {
            selectedShipmentId = 0
        })
        .onChange(of: selectedShipmentId, perform: {newval in
            if selectedShipmentId == newval{
            active = true
            destination = AnyView (DetailsView(shipmentId: selectedShipmentId))
            }else{
                active = true
                destination = AnyView (DetailsView(shipmentId: selectedShipmentId))
            }
        })

        NavigationLink(destination: destination,isActive:$active , label: {
        })
    }
}

struct GarageView_Previews: PreviewProvider {
    static var previews: some View {
        GarageView(FilterTag: .constant(.Menu), showFilter: .constant(false)).environmentObject(ApprovedShipmentViewModel())
    }
}
