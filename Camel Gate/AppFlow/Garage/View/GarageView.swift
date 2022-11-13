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
    @EnvironmentObject var imageVM : imageViewModel

    @State var active = false
    @State var destination = AnyView(DetailsView(shipmentId: 0))
    
    @Binding var FilterTag : FilterCases
    @Binding var showFilter:Bool
    @State var selectedShipmentId = 0
    @State var topPadding:CGFloat = 90

    var body: some View {
        ZStack{
            VStack {
                Spacer().frame(height:hasNotch ? checkforpadding()+20:checkforpadding())
                
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
                }
                
                List($ApprovedShipmentVM.publishedFilteredShipments, id:\.self) { tripItem in
                    Button(action: {
                        active = true
                        destination = AnyView(DetailsView(shipmentId: selectedShipmentId))
                    }, label: {
                        tripCellView(shipmentModel: tripItem, selecteshipmentId: $selectedShipmentId).environmentObject(imageVM)
                    })
                        .onAppear(perform: {
                            if tripItem.id == ApprovedShipmentVM.publishedFilteredShipments.last?.id{
                                ApprovedShipmentVM.SkipCount+=ApprovedShipmentVM.MaxResultCount
                                ApprovedShipmentVM.GetShipmentsOp = .fetchmoreshipments
                                ApprovedShipmentVM.GetFilteredShipments(operation: .fetchmoreshipments)
                            }
                        })
                    
                        .buttonStyle(.plain)
                                                    .listRowBackground(Color.clear)
                                                    .listRowSeparator(.hidden)
                        .padding(.horizontal,-12)
            }
                .listStyle(.plain)
                .listStyle(.plain)
                    .refreshable(action: {
                        ApprovedShipmentVM.SkipCount = 0
                        ApprovedShipmentVM.GetFilteredShipments(operation: .fetchshipments)
                })

            }

            TitleBar(Title: "Garage_Shipments".localized(language), navBarHidden: true, trailingButton: .filterButton, applyStatus: Optional.none, trailingAction: {
                showFilter.toggle()
            })
        }
        .overlay(
           ZStack{
               if ApprovedShipmentVM.nodata == true {
                   Text("Sorry,\nNo_Shipments_Found_🤷‍♂️".localized(language))
                       .multilineTextAlignment(.center)
                       .frame(width:UIScreen.main.bounds.width-10,alignment:.center)
               }
           }
       )
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

        .onAppear(perform: {
            selectedShipmentId = 0
            ApprovedShipmentVM.SkipCount = 0
            ApprovedShipmentVM.GetFilteredShipments(operation: .fetchshipments)
        })
        .onDisappear(perform: {
            ApprovedShipmentVM.resetFilter()
        })
        .onChange(of: selectedShipmentId, perform: {newval in
            if selectedShipmentId == newval{
            active = true
            destination = AnyView (DetailsView(shipmentId: selectedShipmentId).environmentObject(imageVM))
            }else{
                active = true
                destination = AnyView (DetailsView(shipmentId: selectedShipmentId).environmentObject(imageVM))
            }
        })
        .overlay(content: {
            AnimatingGif(isPresented: $ApprovedShipmentVM.isLoading)
        })

        NavigationLink(destination: destination,isActive:$active , label: {
        })
        
        // Alert with no internet connection
            .alert(isPresented: $ApprovedShipmentVM.isAlert, content: {
                Alert(title: Text(ApprovedShipmentVM.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                    if ApprovedShipmentVM.activeAlert == .unauthorized{
                        Helper.logout()
                        LoginManger.removeUser()
                        Helper.IsLoggedIn(value: false)
                        destination = AnyView(SignInView())
                        active = true
                    }
                    ApprovedShipmentVM.isAlert = false
                }))
            })
    }
    func checkforpadding()->CGFloat{
        if    ApprovedShipmentVM.fromCityId != 0
                ||                ApprovedShipmentVM.fromCityName != ""
                ||               ApprovedShipmentVM.toCityId != 0
                ||             ApprovedShipmentVM.toCityName != ""
                ||           ApprovedShipmentVM.fromDateStr != ""
                ||         ApprovedShipmentVM.toDateStr != ""
                ||       ApprovedShipmentVM.shipmentTypesIds   != []
                ||     ApprovedShipmentVM.shipmentTypesNames != []{
            return 140
//            return true
        }else{
//            return false
            return 120
        }
                
    }
}

struct GarageView_Previews: PreviewProvider {
    static var previews: some View {
        GarageView(FilterTag: .constant(.Menu), showFilter: .constant(false)).environmentObject(ApprovedShipmentViewModel()).environmentObject(imageViewModel())
        
    }
}
