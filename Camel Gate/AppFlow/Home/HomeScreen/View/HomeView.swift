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
    @EnvironmentObject var imageVM : imageViewModel
    var body: some View {
        GeometryReader { g in
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
                    
                    ScrollView{
                    if ApprovedShipmentVM.publishedapprovedShipmentModel != nil{
                        ShipView(ShowMapRedirector:$ShowMapRedirector,longitude:$longitude,latitude:$latitude).shadow(radius: 5)
                            .environmentObject(ApprovedShipmentVM)
                        
                    }
                    FilterHeaderView(action: {
                        showFilter.toggle()
                        FilterTag = .Menu
                    })
                        .padding(.bottom,-25)
                                ExtractedView(active: $active, destination: $destination,  selectedShipmentId: $selectedShipmentId)
                                .environmentObject(ApprovedShipmentVM)
                                .environmentObject(imageVM)
                                .frame( height: (g.size.height / 2)+(hasNotch ? 90:0), alignment: .center)
                            .padding(.horizontal,-10)
                    }
                    .frame( height: (g.size.height / 2)+(hasNotch ? 120:40), alignment: .center)

                .padding(.horizontal,10)
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
                .padding(.top,30)
                    .environmentObject(imageVM)
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
                .padding(.bottom, 50)
            }
            .environmentObject(imageVM)
                    .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
            .navigationBarHidden(true)
            .onAppear(perform: {
                selectedShipmentId = 0
                ApprovedShipmentVM.GetApprovedShipment()
                ApprovedShipmentVM.GetFilteredShipments()
            })

            .onChange(of: selectedShipmentId, perform: {newval in
                    active = true
                destination = AnyView (DetailsView(shipmentId: selectedShipmentId).environmentObject(imageVM))
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
                }.padding(.bottom)
            )
            .overlay(content: {
                // showing loading indicator
                AnimatingGif(isPresented: $ApprovedShipmentVM.isLoading)
            })
        // Alert with no internet connection
            .alert(isPresented: $ApprovedShipmentVM.isAlert, content: {
                Alert(title: Text(ApprovedShipmentVM.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                    if ApprovedShipmentVM.activeAlert == .unauthorized{
                        Helper.logout()
                        LoginManger.removeUser()
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
        HomeView(FilterTag: .constant(.Menu), showFilter: .constant(false))
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
            .environmentObject(imageViewModel())
            .environmentObject(ApprovedShipmentViewModel())
    }
}


