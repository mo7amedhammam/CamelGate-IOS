//
//  FilteredFhipmentsView.swift
//  Camel Gate
//
//  Created by wecancity on 17/10/2022.
//

import Foundation
import SwiftUI
struct FilteredShipmentsView: View {
    var language = LocalizationService.shared.language
    
    @EnvironmentObject var imageVM : camelEnvironments
    @EnvironmentObject var ApprovedShipmentVM : ApprovedShipmentViewModel
    @Binding var active : Bool
    @Binding var destination : AnyView
    @Binding var selectedShipmentId : Int
    
    var body: some View {
//        List{
                       VStack {
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
                .padding(.horizontal)
                                .padding(.top,25)
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            //            ScrollView {
            //                LazyVStack {
//            ForEach($ApprovedShipmentVM.publishedFilteredShipments, id:\.self) { tripItem in
//                Button(action: {
//                    active = true
//                    destination = AnyView(DetailsView(shipmentId: selectedShipmentId))
//                }, label: {
//                    tripCellView(shipmentModel: tripItem, selecteshipmentId: $selectedShipmentId).environmentObject(imageVM)
//                })
//                    .buttonStyle(.plain)
//                //                                .listRowBackground(Color.clear)
//                //                                .listRowSeparator(.hidden)
//                    .padding(.horizontal,-12)
                //                                        .onAppear(perform: {
                //                                            if tripItem.id == ApprovedShipmentVM.publishedFilteredShipments.last?.id{
                //                                                ApprovedShipmentVM.SkipCount+=ApprovedShipmentVM.MaxResultCount
                //                                                    ApprovedShipmentVM.GetFilteredShipments(operation: .fetchmoreshipments)
                //                                            }
                //                                        })
//            }
//            .listRowBackground(Color.clear)
//            .listRowSeparator(.hidden)
            
            if ApprovedShipmentVM.publishedFilteredShipments.count > 3{
                Color(#colorLiteral(red: 0.3571086526, green: 0.2268399, blue: 0.5710855126, alpha: 0.09))
                    .frame(height: 1)
                    .padding(.horizontal, 5)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .onAppear(perform: {
                        if ApprovedShipmentVM.publishedFilteredShipments.count > 0{
                            ApprovedShipmentVM.SkipCount+=ApprovedShipmentVM.MaxResultCount
                            ApprovedShipmentVM.GetFilteredShipments(operation: .fetchmoreshipments)
                        }else{
                            
                        }
                    })
                
            }
            //                }
            //            }
        }
        .padding(.top,-40)
        .padding(.horizontal, 5)
        .refreshable(action: {
            ApprovedShipmentVM.GetFilteredShipments(operation: .fetchshipments)
        })
        .listStyle(.plain)
        .onAppear(perform: {
            ApprovedShipmentVM.SkipCount = 0
        })
        .onChange(of: ApprovedShipmentVM.fromCityName, perform: {_ in
            ApprovedShipmentVM.GetFilteredShipments(operation: .fetchshipments)
        })
        .onChange(of: ApprovedShipmentVM.fromDateStr, perform: {_ in
            ApprovedShipmentVM.GetFilteredShipments(operation: .fetchshipments)
        })
        .onChange(of: ApprovedShipmentVM.shipmentTypesNames, perform: {_ in
            ApprovedShipmentVM.GetFilteredShipments(operation: .fetchshipments)
        })
    }
}

struct ExtractedView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            FilteredShipmentsView(active: .constant(false), destination: .constant(AnyView(ChatsListView())), selectedShipmentId: .constant(0))
                .environmentObject(camelEnvironments())
                .environmentObject(ApprovedShipmentViewModel())
            
        }
    }
}


