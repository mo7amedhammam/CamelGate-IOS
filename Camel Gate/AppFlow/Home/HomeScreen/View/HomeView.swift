//
//  HomeView.swift
//  Camel Gate
//
//  Created by wecancity on 21/07/2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject var ApprovedShipmentVM = ApprovedShipmentViewModel()

    
    @State private var selectedFilterId : Int?
    private var filterArray = ["Ciro to Alex" , "6K to 10k SAR" , "Cairo to Alex" ,  "6K to 10k SAR" , "Ciro to Alex"]
    
    @State var active = false
    @State var destination = AnyView(ChatsListView())
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
                if ApprovedShipmentVM.publishedUserLogedInModel != nil{
                ShipView().shadow(radius: 5)
                }
                    FilterHeaderView()
                    ScrollView(.horizontal , showsIndicators : false) {
                        HStack {
                            ForEach(0 ..< filterArray.count) { filterItem in
                                FilterView(delete: filterItem != selectedFilterId , filterTitle: filterArray[filterItem] , D: {
                                    selectedFilterId = filterItem
                                })
                            }
                        }.padding()
                    }
                    ScrollView(.vertical , showsIndicators : false) {
                        VStack{
                            ForEach(0 ..< 5) { tripItem in
                                tripCellView()
                                    .padding(.horizontal)
                            }.onTapGesture {
                                active = true
                                destination = AnyView(DetailsView(shipmentId: selectedShipmentId))
                            }
                        }
                    }
                }
            }.padding(.top,30)
            
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
        .onAppear(perform: {
//            DispatchQueue.main.async {
            ApprovedShipmentVM.GetApprovedShipment()
            ApprovedShipmentVM.GetFilteredShipments()
//            }
        })
        NavigationLink(destination: destination,isActive:$active , label: {
        })

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
        HomeView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
    }
}
