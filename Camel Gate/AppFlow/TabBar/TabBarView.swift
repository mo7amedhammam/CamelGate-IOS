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
    var body: some View {
        VStack(spacing: 0){
            GeometryReader{_ in
                ZStack{
                    if selectedTab == "Home"{
                        HomeView()
                    } else if selectedTab == "Shipments"{
                        ShipmentsView()
                        
                    }  else if selectedTab == "Garage"{
                        GarageView()
                        
                    } else if selectedTab == "Wallet"{
                        WalletView()
                        
                    }else if selectedTab == "Profile"{
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
            .padding(.horizontal , 30)
            .padding(.bottom,edges!.bottom == 0 ? 15 : edges!.bottom)
            .background(Color.white)
            .cornerRadius(30)
            .shadow(color: Color.black, radius: 0.3, x: 0, y: 4)
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

