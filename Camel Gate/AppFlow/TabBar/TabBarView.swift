//
//  TabBarView.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 7/18/22.
//

import SwiftUI
var language = LocalizationService.shared.language

var tabs = ["Home","Shipments","Garage","Wallet","Profile"]
struct TabBarView: View {
    var body: some View {
        NavigationView{
            MainTabBar()
        }
    }
}

struct MainTabBar : View {
    @AppStorage("language")
    var language = LocalizationService.shared.language
    
    @State var selectedTab = "Home"
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @Namespace var animation
    @State var tabs = ["Home","Shipments","Garage","Wallet","Profile"]
    @State var FilterTag : FilterCases = .Menu
    @State var showFilter = false
    //    @State var resetFilter = false
    @StateObject var ApprovedShipmentVM = ApprovedShipmentViewModel()
    @StateObject var environments = camelEnvironments()

    var body: some View {
        VStack(spacing: 0){
            GeometryReader{_ in
                ZStack{
                    if self.selectedTab.localized(language) == "Home".localized(language){
                        HomeView(FilterTag: $FilterTag, showFilter: $showFilter)
                            .environmentObject(ApprovedShipmentVM)
                            .environmentObject(environments)
                        
                    } else if self.selectedTab.localized(language) == "Shipments".localized(language){
                        ShipmentsView()
                        
                    }  else if self.selectedTab.localized(language) == "Garage".localized(language){
                        GarageView(FilterTag: $FilterTag, showFilter: $showFilter)
                            .environmentObject(ApprovedShipmentVM)
                        
                    } else if self.selectedTab.localized(language) == "Wallet".localized(language){
                        WalletView( SelectedTab: $selectedTab)
                            .environmentObject(environments)
                        
                    }else if self.selectedTab.localized(language) == "Profile".localized(language){
                        ProfileView()
                    }
                }.environmentObject(environments)
                    .navigationViewStyle(StackNavigationViewStyle())
                    .ignoresSafeArea()
            }
            HStack(spacing: 0){
                ForEach(tabs , id : \.self){tab in
                    TabButton(title: tab, selectedTab: $selectedTab, animation: animation)
                    if tab != tabs.last {
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal , 20)
            .padding(.bottom,edges!.bottom == 0 ? hasNotch ? 15:5 : edges!.bottom-15)
            .background(
                RoundedCornersShape(radius: 30, corners: [.topLeft,.topRight])
                    .foregroundColor(.white)
            )
        }
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
        .sheet(isPresented: $environments.isPresented){
            ImagePreviewer(IsPresented: $environments.isPresented, imageUrl: $environments.imageUrl)
        }
        .onChange(of: environments.desiredTab, perform: {newval in
            selectedTab = newval
        })
        .ignoresSafeArea(.all, edges: .bottom)
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
        .overlay(
            VStack{
                //                MARK: -- filter sheet --
                if showFilter{
                    BottomSheetView(IsPresented: $showFilter, withcapsule: true, bluryBackground: true,  forgroundColor: .white, content: {
                        MainFilterView(FilterTag: $FilterTag, showFilter: $showFilter)
                            .environmentObject(ApprovedShipmentVM)
                            .padding()
                            .padding(.bottom,hasNotch ? 0:-10)
                    })
                }else if environments.ShowMapRedirector {
                    BottomSheetView(IsPresented: $environments.ShowMapRedirector, withcapsule: true, bluryBackground: true,  forgroundColor: .white, content: {
                        RedirectToGMaps(ShowRedirector: $environments.ShowMapRedirector, Long: environments.Destinationlongitude, Lat: environments.Destinationlongitude)
                            .padding()
                            .frame(height: 190)
                    })
                }else if ApprovedShipmentVM.CanRateApprovedshipment{
                    BottomSheetView(IsPresented: $ApprovedShipmentVM.CanRateApprovedshipment, withcapsule: true, bluryBackground: true,  forgroundColor: .white, content: {
                       RateSheetView()
                            .environmentObject(ApprovedShipmentVM)
                            .padding(.horizontal)
                            .padding(.bottom,hasNotch ? 0:-10)
                    })
                }
            }.padding(.bottom, hasNotch ? 0:-20)
        )
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            TabBarView()
        }
        ZStack {
            TabBarView()
        }.previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
    }
}


