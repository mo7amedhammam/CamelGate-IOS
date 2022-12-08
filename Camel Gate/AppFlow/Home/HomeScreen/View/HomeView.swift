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
                                    .padding(.horizontal,-12)
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
                DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                    getDate()
                })
            })
            
            .onChange(of: selectedShipmentId, perform: {newval in
                active = true
                destination = AnyView (DetailsView(shipmentId: selectedShipmentId).environmentObject(environments))
            })
        }
        
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


