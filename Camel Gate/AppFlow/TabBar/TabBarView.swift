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
    @State var selectedTab = "Home"
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @Namespace var animation
    @State var tabs = ["Home","Shipments","Garage","Wallet","Profile"]
    @State var FilterTag : FilterCases = .Menu
    @State var showFilter = false
    @StateObject var ApprovedShipmentVM = ApprovedShipmentViewModel()

    var body: some View {
        VStack(spacing: 0){
            GeometryReader{_ in
                ZStack{
                    if self.selectedTab == "Home"{
                        HomeView(FilterTag: $FilterTag, showFilter: $showFilter)
                            .environmentObject(ApprovedShipmentVM)
                    } else if self.selectedTab == "Shipments"{
                        ShipmentsView()
                        
                    }  else if self.selectedTab == "Garage"{
                        GarageView(FilterTag: $FilterTag, showFilter: $showFilter)
                            .environmentObject(ApprovedShipmentVM)
                        
                    } else if self.selectedTab == "Wallet"{
                        WalletView()
                        
                    }else if self.selectedTab == "Profile"{
                        ProfileView()

                    }
                }
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
            .padding(.bottom,edges!.bottom == 0 ? 15 : edges!.bottom-15)
            .background(
                RoundedCornersShape(radius: 30, corners: [.topLeft,.topRight])
                    .foregroundColor(.white)
            )
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
        .overlay(
            VStack{
            if showFilter{
                            BottomSheetView(IsPresented: $showFilter, withcapsule: true, bluryBackground: true, forgroundColor: .white, content: {
//                FilterMenu(FilterTag: $FilterTag , showFilter: $showFilter)
//                                    .environmentObject(ApprovedShipmentVM)
//                                    .padding()
                MainFilterView(FilterTag: $FilterTag, showFilter: $showFilter)
                                    .environmentObject(ApprovedShipmentVM)
                                    .padding()

                            })
                

            }
                Spacer(minLength: 40)
            }.padding(.bottom)
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

