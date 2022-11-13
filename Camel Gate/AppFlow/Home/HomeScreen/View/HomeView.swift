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

    @EnvironmentObject var ApprovedShipmentVM : ApprovedShipmentViewModel
  
    @State var active = false
    @State var destination = AnyView(ChatsListView())
    
    @Binding var FilterTag : FilterCases
    @Binding var showFilter:Bool

    @State var ShowMapRedirector:Bool = false
    @State var longitude:Double = 0
    @State var latitude:Double = 0
    @State var selectedShipmentId = 0
    @EnvironmentObject var environments : imageViewModel

    var body: some View {
        GeometryReader { g in
            ZStack{
                VStack {
                    ZStack {
                        Image("homeTopMask")
                            .resizable()
                    }.frame(maxWidth: .infinity, maxHeight: hasNotch ? 240:200).background(Color.clear)
                    Spacer()
                }.edgesIgnoringSafeArea(.all)

                VStack(spacing: 0){
                    HeaderView()
                    WalletIcon()
                        .environmentObject(environments)
                    
                    List() {
                    if ApprovedShipmentVM.publishedapprovedShipmentModel != nil{
                        ShipView(ShowMapRedirector:$ShowMapRedirector,longitude:$longitude,latitude:$latitude)
                            .shadow(radius: 5)
                            .environmentObject(ApprovedShipmentVM)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)

                        
                    }
                    FilterHeaderView(action: {
                        showFilter.toggle()
                        FilterTag = .Menu
                    })
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)

                        .padding(.bottom,-25)
                        .padding(.horizontal,10)
//                        ZStack {
//                            FilteredShipmentsView(active: $active, destination: $destination,  selectedShipmentId: $selectedShipmentId)
//                                    .environmentObject(ApprovedShipmentVM)
//                                    .environmentObject(environments)
//                                    .frame( height: (g.size.height / 2)+(hasNotch ? 90:20), alignment: .center)
//    //                            .padding(.horizontal,-2)
//
//                        }.listRowBackground(Color.clear)
//                        .listRowSeparator(.hidden)
                        
//                        .frame( height: (g.size.height / 2)+(hasNotch ? 120:60), alignment: .center)

                        
//                        if ApprovedShipmentVM.publishedFilteredShipments.count > ApprovedShipmentVM.MaxResultCount{
//                            Color(#colorLiteral(red: 0.3571086526, green: 0.2268399, blue: 0.5710855126, alpha: 0.09))
//                                .frame(height: 1)
//                                .padding(.horizontal, 5)
//                                .listRowBackground(Color.clear)
//                                .listRowSeparator(.hidden)
//                                .onAppear(perform: {
//                                    if ApprovedShipmentVM.publishedFilteredShipments.count > 0{
//                                    ApprovedShipmentVM.SkipCount+=ApprovedShipmentVM.MaxResultCount
//            //                        ApprovedShipmentVM.GetShipmentsOp = .fetchmoreshipments
//                                        ApprovedShipmentVM.GetFilteredShipments(operation: .fetchmoreshipments)
//                                    }else{
//
//                                    }
//                                })
//
//                        }
            //                    .onChange(of: ApprovedShipmentVM.SkipCount, perform: {newval in
            //                        ApprovedShipmentVM.SkipCount = newval
            //                        ApprovedShipmentVM.GetFilteredShipments(operation: .fetchmoreshipments)
            //                    })

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
                            }
                            
                            
                            List($ApprovedShipmentVM.publishedFilteredShipments, id:\.self) { tripItem in
                                Button(action: {
                                    active = true
                                    destination = AnyView(DetailsView(shipmentId: selectedShipmentId))
                                }, label: {
                                    tripCellView(shipmentModel: tripItem, selecteshipmentId: $selectedShipmentId)
                                        .environmentObject(environments)
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
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .frame( height: (g.size.height / 2)+(hasNotch ? 120:60), alignment: .center)

                    }
                    .padding(.vertical,-30)
                    .padding(.horizontal,-15)

                    .refreshable {
                        ApprovedShipmentVM.SkipCount = 0
                        ApprovedShipmentVM.GetFilteredShipments(operation: .fetchshipments)
                    }
                    .listStyle(.plain)
//                    .frame( height: (g.size.height / 2)+(hasNotch ? 120:60), alignment: .center)
                .overlay(
                    ZStack{
                        if ApprovedShipmentVM.nodata == true {
                            Text("Sorry,\nNo_Shipments_Found_🤷‍♂️".localized(language))
                                .multilineTextAlignment(.center)
                                .frame(width:UIScreen.main.bounds.width-40,alignment:.center)
                        }
                    }
                )
                }
                .padding(.top,hasNotch ? 30:15)
                .environmentObject(environments)
                VStack {
                    Spacer()
                    HStack{
                        Spacer()
                        Button(action: {
                            active = true
                            destination = AnyView (ChatsListView())
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
                selectedShipmentId = 0
                ApprovedShipmentVM.GetApprovedShipment()
                ApprovedShipmentVM.GetFilteredShipments(operation: .fetchshipments)
            })
            .onDisappear(perform: {
                ApprovedShipmentVM.resetFilter()
            })
            .onChange(of: selectedShipmentId, perform: {newval in
                    active = true
                destination = AnyView (DetailsView(shipmentId: selectedShipmentId).environmentObject(environments))
        })
        }

        NavigationLink(destination: destination,isActive:$active , label: {
        })
            .overlay(
                VStack{
                    if ShowMapRedirector{
                        BottomSheetView(IsPresented: $ShowMapRedirector, withcapsule: true, bluryBackground: true,  forgroundColor: .white, content: {
                            RedirectToGMaps(ShowRedirector: $ShowMapRedirector, Long: longitude, Lat: latitude)
                                .padding()
                                .frame( height: 190)
                        })
                    }
                    Spacer(minLength: 40)
                }
                    .padding(.bottom)
            )

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
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(FilterTag: .constant(.Menu), showFilter: .constant(false))
            .environmentObject(ApprovedShipmentViewModel())
            .environmentObject(imageViewModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        HomeView(FilterTag: .constant(.Menu), showFilter: .constant(false))
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
            .environmentObject(imageViewModel())
            .environmentObject(ApprovedShipmentViewModel())
    }
}


