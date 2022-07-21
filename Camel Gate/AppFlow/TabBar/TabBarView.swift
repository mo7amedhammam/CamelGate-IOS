//
//  TabBarView.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 7/18/22.
//

import SwiftUI

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
  var body: some View {
    VStack(spacing: 0){
      GeometryReader{_ in
        ZStack{
            VStack{
                Image("homeTopMask")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                HeaderView()
                WalletView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .opacity(selectedTab == "Home" ? 1 : 0)
            
            Text("Shipments")
                .opacity(selectedTab == "Shipments" ? 1 : 0)

            Text("Garage")
                .opacity(selectedTab == "Garage" ? 1 : 0)

            Text("Wallet")
                .opacity(selectedTab == "Wallet" ? 1 : 0)

            Text("Profile")
              .opacity(selectedTab == "Profile" ? 1 : 0)
        }
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
// Tab Button...
struct TabButton : View {
  var title : String
  @Binding var selectedTab : String
  var animation : Namespace.ID

  var body: some View{
    Button(action: {
      withAnimation{selectedTab = title}
    }) {
      VStack(spacing: 6){
        ZStack{
          CustomShape()
            .fill(Color.clear)
            .frame(width: 45, height: 6)

          if selectedTab == title{
            CustomShape()
              .fill(Color("Base_Color"))
              .frame(width: 60, height: 6)
              .matchedGeometryEffect(id: "Tab_Change", in: animation)
              .shadow(color: Color("Base_Color"), radius: 10, x: 0, y: 0)
          }
        }
        .padding(.bottom,10)

        Image(title)
          .renderingMode(.template)
          .resizable()
          .foregroundColor(selectedTab == title ? Color("Second_Color") : Color.black.opacity(0.2))
          .frame(width: 24, height: 24)

        Text(title)
          .font(.caption)
          .fontWeight(.bold)
          .foregroundColor(Color("Base_Color").opacity(selectedTab == title ? 1.0 : 0.2))
      }
    }
  }
}

// Custom Shape..
struct CustomShape : Shape {
  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 10, height: 10))
    return Path(path.cgPath)
  }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

struct WalletView: View {
    var body: some View {
        HStack{
            ZStack(alignment: .leading ){
                Image("ic_back_wallet").resizable().scaledToFit()
                VStack(spacing: 8 ){
                    Image("ic_wallet")
                    Text("Wallet").foregroundColor(Color.white.opacity(0.7))
                    Text("12,400").foregroundColor(Color.white)
                }.padding()
            }.frame(height: 140)
            ZStack(alignment: .leading ){
                VStack(spacing: 0 ){
                    HStack{
                        Image("ic_car_track")
                        VStack(alignment: .leading ){
                            Text("21").foregroundColor(Color(#colorLiteral(red: 0.356864363, green: 0.3568614721, blue: 0.2826236188, alpha: 1)))
                                .font(.custom("SFUIText-Bold", fixedSize: 20))
                            Text("Upcoming Trips")
                                .foregroundColor(Color(#colorLiteral(red: 0.356864363, green: 0.3568614721, blue: 0.2826236188, alpha: 1)))
                                .font(.custom("SFUIText-Medium", fixedSize: 12))
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(height: 60)
                    Color(#colorLiteral(red: 0.9281044006, green: 0.9126986861, blue: 0.9479321837, alpha: 1)).frame(height: 2)
                    HStack{
                        Image("ic_money")
                        VStack(alignment: .leading ){
                            Text("6,700").foregroundColor(Color(#colorLiteral(red: 0.356864363, green: 0.3568614721, blue: 0.2826236188, alpha: 1)))
                                .font(.custom("SFUIText-Bold", fixedSize: 20))
                            Text("This Month Money")
                                .foregroundColor(Color(#colorLiteral(red: 0.356864363, green: 0.3568614721, blue: 0.2826236188, alpha: 1)))
                                .font(.custom("SFUIText-Medium", fixedSize: 12))
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(height: 60)
                }
            }
            .background(Color.white)
            .clipped()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color("Base_Color"), lineWidth: 0.2)
            )
            .cornerRadius(12)
            .shadow(color: Color("Base_Color").opacity(0.08), radius: 3.0 , x: 0, y: 4)
            
        }.padding()
    }
}
