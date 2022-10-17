//
//  FilteredFhipmentsView.swift
//  Camel Gate
//
//  Created by wecancity on 17/10/2022.
//

import Foundation
import SwiftUI
struct ExtractedView: View {
    var language = LocalizationService.shared.language

    @EnvironmentObject var imageVM : imageViewModel
    @EnvironmentObject var ApprovedShipmentVM : ApprovedShipmentViewModel
    @Binding var active : Bool
    @Binding var destination : AnyView
    @Binding var selectedShipmentId : Int

    var body: some View {
        VStack{
            ScrollView(.horizontal , showsIndicators : false) {
                HStack {
                    if ApprovedShipmentVM.fromCityName != ""{
                        FilterView(delete: true, filterTitle: "\(ApprovedShipmentVM.fromCityName) to \(ApprovedShipmentVM.toCityName)", D: {
                            ApprovedShipmentVM.fromCityName = ""
                            ApprovedShipmentVM.toCityName = ""
                            ApprovedShipmentVM.fromCityId = 0
                            ApprovedShipmentVM.toCityId = 0

                        })
                    }
                    if ApprovedShipmentVM.fromDateStr != ""{
                        FilterView(delete: true, filterTitle: "\(ApprovedShipmentVM.fromDate.DateToStr(format: "dd/MM/yyyy")) to \(ApprovedShipmentVM.toDateStr != "" ? ApprovedShipmentVM.toDate.DateToStr(format: "dd/MM/yyyy"):"")", D: {
                            ApprovedShipmentVM.fromDateStr = ""
                            ApprovedShipmentVM.toDateStr = ""
                            ApprovedShipmentVM.fromDate = Date()
                            ApprovedShipmentVM.toDate = Date()

                        })
                    }
                    if ApprovedShipmentVM.shipmentTypesIds != []{
                        FilterView(delete: true, filterTitle: "\(ApprovedShipmentVM.shipmentTypesNames.joined(separator: ", "))", D: {
                            ApprovedShipmentVM.shipmentTypesIds = []
                            ApprovedShipmentVM.shipmentTypesNames = []
                        })
                    }
                    
                }
                .padding(.top,25)
            }
            List() {
                    ForEach($ApprovedShipmentVM.publishedFilteredShipments, id:\.self) { tripItem in
                            Button(action: {
                                active = true
                                destination = AnyView(DetailsView(shipmentId: selectedShipmentId))
                            }, label: {
                                tripCellView(shipmentModel: tripItem, selecteshipmentId: $selectedShipmentId).environmentObject(imageVM)
                            })
                                .buttonStyle(.plain)
                                .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                        .padding(.horizontal,-10)
                    }
            }
            .refreshable(action: {
                ApprovedShipmentVM.GetFilteredShipments()
            })
                .listStyle(.plain)
        }        
                
        .onChange(of: ApprovedShipmentVM.fromCityName, perform: {_ in
            ApprovedShipmentVM.GetFilteredShipments()
        })
        .onChange(of: ApprovedShipmentVM.fromDateStr, perform: {_ in
            ApprovedShipmentVM.GetFilteredShipments()
        })
        .onChange(of: ApprovedShipmentVM.shipmentTypesNames, perform: {_ in
            ApprovedShipmentVM.GetFilteredShipments()
        })
    }
}

struct ExtractedView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ExtractedView(active: .constant(false), destination: .constant(AnyView(ChatsListView())), selectedShipmentId: .constant(0))
                .environmentObject(imageViewModel())
                .environmentObject(ApprovedShipmentViewModel())

        }
    }
}


