//
//  HomeView.swift
//  Camel Gate
//
//  Created by wecancity on 21/07/2022.
//

import SwiftUI

struct HomeView: View {
    //    @AppStorage("language")
    var language = LocalizationService.shared.language
    @StateObject var locationVM = LocationAddressVM()
    @EnvironmentObject var ApprovedShipmentVM : ApprovedShipmentViewModel
    @EnvironmentObject var environments : camelEnvironments
    @EnvironmentObject var driverRate : DriverRateViewModel
    @State var active = false
    @State var destination = AnyView(ChatsListView())
    
    @Binding var FilterTag : FilterCases
    @Binding var showFilter:Bool
    @State var selectedShipmentId = 0
    
    var body: some View {
        GeometryReader { g in
            ZStack{
                VStack {
                    ZStack {
                        Image("homeTopMask")
                            .resizable()
                    }.frame(maxWidth: .infinity, maxHeight: hasNotch ? 240:200).background(Color.clear)
                    Spacer()
                }
                .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0){
                    HeaderView()
                        .environmentObject(locationVM)
                        .environmentObject(driverRate)
                        .environmentObject(environments)

                    WalletIcon()
                        .padding(.top)
                        .environmentObject(environments)
                    
                    List() {
                        if ApprovedShipmentVM.publishedapprovedShipmentModel != nil{
                            ShipView()
                                .shadow(radius: 5)
                                .environmentObject(ApprovedShipmentVM)
                                .environmentObject(environments)
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .padding(.horizontal)
                        }
                        Section {
                            ForEach($ApprovedShipmentVM.publishedFilteredShipments, id:\.self) { tripItem in
                                Button(action: {
                                    active = true
                                    destination = AnyView(DetailsView(shipmentId: selectedShipmentId))
                                }, label: {
                                    tripCellView(shipmentModel: tripItem, selecteshipmentId: $selectedShipmentId)
                                        .environmentObject(environments)
                                })
                                    .onAppear(perform: {
//                                       if ApprovedShipmentVM.nomoredata == false{
                                           if ApprovedShipmentVM.publishedFilteredShipments.count >= ApprovedShipmentVM.MaxResultCount && (tripItem.id == ApprovedShipmentVM.publishedFilteredShipments.last?.id){
                                            ApprovedShipmentVM.SkipCount+=ApprovedShipmentVM.MaxResultCount
                                            ApprovedShipmentVM.GetShipmentsOp = .fetchmoreshipments
                                            ApprovedShipmentVM.GetFilteredShipments(operation: .fetchmoreshipments)
                                        }else{
//                                            ApprovedShipmentVM.SkipCount = 0
                                            
                                        }
//                                       }else{
//
//                                       }
                                    })
                                    .buttonStyle(.plain)
                                    .listRowBackground(Color.clear)
                                    .listRowSeparator(.hidden)
                                    .padding(.horizontal,-8)
                                    .padding(.bottom,8)
                            }
                            //                            .padding(.bottom,25)
                            .listStyle(.plain)
                            .refreshable(action: {
                                ApprovedShipmentVM.SkipCount = 0
                                ApprovedShipmentVM.GetFilteredShipments(operation: .fetchshipments)
                            })
                            Spacer().frame(height:30)
                            ZStack{
                                if ApprovedShipmentVM.nodata == true {
                                    Text("Sorry,\nNo_Shipments_Found_🤷‍♂️".localized(language))
                                        .multilineTextAlignment(.center)
                                        .frame(width:UIScreen.main.bounds.width-40,alignment:.center)
                                }
                            }
                        }header:{
                            VStack{
                                FilterHeaderView(action: {
                                    showFilter.toggle()
                                    FilterTag = .Menu
                                })
                                //                                        .listRowBackground(Color.clear)
                                //                                        .listRowSeparator(.hidden)
                                //                                    .padding(.bottom,-25)
                                //                                    .padding(.horizontal,10)
                                FilterCapsules()
                                    .environmentObject(ApprovedShipmentVM)
//                                ScrollView(.horizontal , showsIndicators : false) {
//                                    HStack {
//                                        if (ApprovedShipmentVM.fromCityName != "" || ApprovedShipmentVM.toCityName != ""){
//                                            FilterView(delete: true, filterTitle: "\(ApprovedShipmentVM.fromCityName) " + "\("To".localized(language))" + " \(ApprovedShipmentVM.toCityName)", D: {
//                                                ApprovedShipmentVM.fromCityName = ""
//                                                ApprovedShipmentVM.toCityName = ""
//                                                ApprovedShipmentVM.fromCityId = 0
//                                                ApprovedShipmentVM.toCityId = 0
//                                                ApprovedShipmentVM.GetFilteredShipments(operation: .fetchshipments)
//                                            })
//                                        }
//                                        if (ApprovedShipmentVM.fromDateStr != "" || ApprovedShipmentVM.toDateStr != ""){
//                                            FilterView(delete: true, filterTitle: "\(ApprovedShipmentVM.fromDate.DateToStr(format:  language.rawValue == "en" ? "dd/MM/yyyy":"yyyy/MM/dd")) " + "\("To".localized(language))" + " \(ApprovedShipmentVM.toDateStr != "" ? ApprovedShipmentVM.toDate.DateToStr(format:  language.rawValue == "en" ? "dd/MM/yyyy":"yyyy/MM/dd"):"")", D: {
//                                                ApprovedShipmentVM.fromDateStr = ""
//                                                ApprovedShipmentVM.toDateStr = ""
//                                                ApprovedShipmentVM.fromDate = Date()
//                                                ApprovedShipmentVM.toDate = Date()
//                                                ApprovedShipmentVM.GetFilteredShipments(operation: .fetchshipments)
//                                            })
//                                        }
//                                        if ApprovedShipmentVM.shipmentTypesIds != []{
//                                            FilterView(delete: true, filterTitle: "\(ApprovedShipmentVM.shipmentTypesNames.joined(separator: ", "))", D: {
//                                                ApprovedShipmentVM.shipmentTypesIds = []
//                                                ApprovedShipmentVM.shipmentTypesNames = []
//                                                ApprovedShipmentVM.GetFilteredShipments(operation: .fetchshipments)
//                                            })
//                                        }
//                                    }
//                                    .padding(.horizontal)
//                                }
                            }
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .padding(.horizontal)
                        //                        .frame( height: (g.size.height / 2)+(hasNotch ? 120:60), alignment: .center)
                        //                        .overlay(
                        //                        )
                    }
                    .padding(.top,20)
                    .padding(.vertical,-30)
                    .padding(.horizontal,-15)
                    .refreshable {
                        ApprovedShipmentVM.SkipCount = 0
                        ApprovedShipmentVM.GetFilteredShipments(operation: .fetchshipments)
                        ApprovedShipmentVM.GetApprovedShipment()
                    }
                    .listStyle(.plain)
                    //                    .frame( height: (g.size.height / 2)+(hasNotch ? 120:60), alignment: .center)
                }
                .padding(.top,hasNotch ? 30:15)
                .environmentObject(environments)
                VStack {
                    Spacer()
                    HStack{
                        Spacer()
                        Button(action: {
                            //                            active = true
                            //                            destination = AnyView (ChatsListView())
                            openWhatsApp(number: nil)
                        }, label: {
                            Image("floatingchat")
                        })
                    }.padding()
                }
                .padding(.bottom,hasNotch ? 50:50)
            }
            .overlay(content: {
                // showing loading indicator
                AnimatingGif(isPresented: $ApprovedShipmentVM.isLoading)
            })
            .environmentObject(environments)
            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
            .navigationBarHidden(true)
            .onAppear(perform: {
//                DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                    getDate()
//                })
            })
            
            .onChange(of: selectedShipmentId, perform: {newval in
                active = true
                destination = AnyView (DetailsView(shipmentId: selectedShipmentId).environmentObject(environments))
            })

        }
        .overlay(
            ZStack{
            if ApprovedShipmentVM.isAlert{
                CustomAlert(presentAlert: $ApprovedShipmentVM.isAlert,alertType: .error(title: "", message: ApprovedShipmentVM.message, lefttext: "", righttext: "OK".localized(language)),rightButtonAction: {
                    if ApprovedShipmentVM.activeAlert == .unauthorized{
                        Helper.logout()
                        LoginManger.removeUser()
                        Helper.IsLoggedIn(value: false)
                        destination = AnyView(SignInView())
                        active = true
                    }
                    ApprovedShipmentVM.isAlert = false
                })
                }
                if environments.confirmAlert{
                    CustomAlert(presentAlert: $environments.confirmAlert,alertType: .question(title: "", message: environments.confirmMessage.localized(language), lefttext: "NotNow_".localized(language), righttext: "yes_".localized(language)),leftButtonAction:{
                        environments.confirmAlert = false
//                        environments.confirmMessage = ""
                        environments.isError = false
                        
                    }, rightButtonAction: {
                                ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentStatusId == 2 ?
                                ApprovedShipmentVM.ApprovedAction(operation: .start) :ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentStatusId == 3 ? ApprovedShipmentVM.ApprovedAction(operation: .Upload):ApprovedShipmentVM.ApprovedAction(operation: .finish)
                                    environments.confirmAlert = false
                                    environments.isError = false
                            })
                        }
                                        
            }.ignoresSafeArea()
                .edgesIgnoringSafeArea(.all)
                .onChange(of: ApprovedShipmentVM.isAlert, perform: {newval in
                    DispatchQueue.main.async {
                    environments.isError = newval
                    }
                })
                .onAppear(perform: {
                    if environments.isError == false && ApprovedShipmentVM.isAlert == true{
                        environments.isError = true
                    }
                })
//                .onChange(of: environments.confirmAlert, perform: {newval in
//                    if newval {
//                        showConfirmAlert()
//                    }
//                })

        )
        
        NavigationLink(destination: destination,isActive:$active , label: {
        })
        
    }
    
    func getDate(){
        driverRate.GetDriverRate()
        ApprovedShipmentVM.nomoredata = false
        ApprovedShipmentVM.SkipCount = 0
        selectedShipmentId = 0
        ApprovedShipmentVM.lang = Double(locationVM.lastLocation?.coordinate.longitude ?? 0)
        ApprovedShipmentVM.lat = Double(locationVM.lastLocation?.coordinate.latitude ?? 0)
        ApprovedShipmentVM.resetFilter()
        ApprovedShipmentVM.GetApprovedShipment()
        //        ApprovedShipmentVM.GetFilteredShipments(operation: .fetchshipments)
    }
    
    
//    func showConfirmAlert() {
//
//        switch   ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentStatusId {
//        case 2:
//            environments.confirmMessage="are_you_sure_To_Start_now?"
//        case 3:
//            environments.confirmMessage="are_you_sure_To_Upload_now?"
//        case 4:
//            environments.confirmMessage="Did_you_realy_Finish_Shipment?"
//        default:
//            return
//        }
////        DispatchQueue.main.async(execute: {
//        environments.confirmAlert = true
//        environments.isError = true
////        })
//        //        ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentStatusId == 2 ? confirmMessage="are_you_sure_To_Start_now?":ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentStatusId == 3 ? confirmMessage = "are_you_sure_To_Upload_now?":confirmMessage = "Did_you_realy_Finish_Shipment?"
//    }
    
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(FilterTag: .constant(.Menu), showFilter: .constant(false))
            .environmentObject(ApprovedShipmentViewModel())
            .environmentObject(camelEnvironments())
            .environmentObject(DriverRateViewModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        HomeView(FilterTag: .constant(.Menu), showFilter: .constant(false))
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
            .environmentObject(camelEnvironments())
            .environmentObject(ApprovedShipmentViewModel())
            .environmentObject(DriverRateViewModel())
    }
}


