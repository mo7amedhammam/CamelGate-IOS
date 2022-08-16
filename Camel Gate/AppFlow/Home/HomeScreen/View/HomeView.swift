//
//  HomeView.swift
//  Camel Gate
//
//  Created by wecancity on 21/07/2022.
//

import SwiftUI

struct HomeView: View {
    var language = LocalizationService.shared.language

    @EnvironmentObject var ApprovedShipmentVM : ApprovedShipmentViewModel

    @State  var selectedFilterId : Int?
    @State  var filterArray : [String] = []
    
    @State var active = false
    @State var destination = AnyView(ChatsListView())
    
    @Binding var FilterTag : FilterCases
    @Binding var showFilter:Bool

    @State var ShowMapRedirector:Bool = false
    @State var longitude:Double = 0
    @State var latitude:Double = 0
    @State var selectedShipmentId = 0
    var body: some View {
        ZStack{
            VStack {
                ZStack {
                    Image("homeTopMask")
                        .resizable()
                }.frame(maxWidth: .infinity, maxHeight: 240).background(Color.clear)
                Spacer()
            }.edgesIgnoringSafeArea(.all)

            VStack(spacing: 0){
                HeaderView()
                WalletIcon()
            ScrollView {
                if ApprovedShipmentVM.publishedapprovedShipmentModel != nil{
                    ShipView(ShowMapRedirector:$ShowMapRedirector,longitude:$longitude,latitude:$latitude).shadow(radius: 5)
                        .environmentObject(ApprovedShipmentVM)
                }
                
//                if ApprovedShipmentVM.publishedFilteredShipments != []{
                FilterHeaderView(action: {
                    showFilter.toggle()
                    FilterTag = .Menu
                })
                    .padding(.horizontal)
                    .padding(.bottom,-30)
//                }
                
                ExtractedView(active: $active, destination: $destination, selectedFilterId: $selectedFilterId, filterArray: $filterArray, selectedShipmentId: $selectedShipmentId)
                    .environmentObject(ApprovedShipmentVM)

                }
            .overlay(
                ZStack{
                    if ApprovedShipmentVM.nodata == true {
                        Text("Sorry,\nNo_Shipments_Found_🤷‍♂️".localized(language))
                            .multilineTextAlignment(.center)
                            .frame(width:UIScreen.main.bounds.width-40,alignment:.center)
                    }
                }
            )
            }.padding(.top,30)
            
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
            }.padding(.bottom, 50)
        }
                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

        .navigationBarHidden(true)
        .onAppear(perform: {
            selectedShipmentId = 0
            ApprovedShipmentVM.GetApprovedShipment()
            ApprovedShipmentVM.GetFilteredShipments()
        })

        .onChange(of: selectedShipmentId, perform: {newval in
                active = true
                destination = AnyView (DetailsView(shipmentId: selectedShipmentId))
        })

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
                }.padding(.bottom)
            )
            .overlay(content: {
                // showing loading indicator
                ActivityIndicatorView(isPresented: $ApprovedShipmentVM.isLoading)
            })
        // Alert with no internet connection
            .alert(isPresented: $ApprovedShipmentVM.isAlert, content: {
                Alert(title: Text(ApprovedShipmentVM.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                    ApprovedShipmentVM.isAlert = false
                }))
            })

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(FilterTag: .constant(.Menu), showFilter: .constant(false))
            .environmentObject(ApprovedShipmentViewModel())
        HomeView(FilterTag: .constant(.Menu), showFilter: .constant(false))
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
            .environmentObject(ApprovedShipmentViewModel())

    }
}

struct ExtractedView: View {
    
    @EnvironmentObject var ApprovedShipmentVM : ApprovedShipmentViewModel
    @Binding var active : Bool
    @Binding var destination : AnyView
    
    @Binding  var selectedFilterId : Int?
    @Binding var filterArray : [String]
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
                .padding(.horizontal)
                .padding(.top,25)
            }
            ScrollView(.vertical , showsIndicators : false) {
                VStack{
                    ForEach(ApprovedShipmentVM.publishedFilteredShipments, id:\.self) { tripItem in
                        Button(action: {
                            active = true
                            destination = AnyView(DetailsView(shipmentId: selectedShipmentId))
                        }, label: {
                            tripCellView(shipmentModel: tripItem, selecteshipmentId: $selectedShipmentId)
                                .padding(.horizontal)
                        }).buttonStyle(.plain)
                    }
                }
            }
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
