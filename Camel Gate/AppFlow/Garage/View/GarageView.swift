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

    
    @State  var selectedFilterId : Int?
    @State var filterArray = ["Ciro to Alex" , "6K to 10k SAR" , "Cairo to Alex" ,  "6K to 10k SAR" , "Ciro to Alex"]
    @State var active = false
    @State var destination = AnyView(DetailsView(shipmentId: 0))
    
    @Binding var FilterTag : FilterCases
    @Binding var showFilter:Bool
    @State var selectedShipmentId = 0

    var body: some View {
        ZStack{
//            VStack {
//                Spacer().frame(height: 145 )
//                    ScrollView(.horizontal , showsIndicators : false) {
//                        HStack {
//                            ForEach(0 ..< filterArray.count) { filterItem in
//                                FilterView(delete: filterItem != selectedFilterId , filterTitle: filterArray[filterItem] , D: {
//                                    selectedFilterId = filterItem
//                                })
//                            }
//                        }.padding()
//                    }
//                    ScrollView(.vertical , showsIndicators : false) {
//                        VStack{
//                            ForEach(ApprovedShipmentVM.publishedFilteredShipments,id:\.self) { tripItem in
//                                tripCellView(shipmentModel: tripItem)
//                                    .padding(.horizontal)
//                            }.onTapGesture {
//                                active = true
//                                destination = AnyView(DetailsView(shipmentId: selectedShipmentId))
//                            }
//                        }
//                    }
//                }
            ExtractedView(active: $active, destination: $destination, selectedFilterId: $selectedFilterId, filterArray: $filterArray, selectedShipmentId: $selectedShipmentId)
                .environmentObject(ApprovedShipmentVM)
                .padding(.top,140)
            
            TitleBar(Title: "Garage Shipments", navBarHidden: true, trailingButton: .filterButton, applyStatus: .applyed,subText: "Applied"  ,trailingAction: {
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
