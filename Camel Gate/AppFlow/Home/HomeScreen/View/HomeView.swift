//
//  HomeView.swift
//  Camel Gate
//
//  Created by wecancity on 21/07/2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var ApprovedShipmentVM : ApprovedShipmentViewModel

    
    @State  var selectedFilterId : Int?
    @State  var filterArray = ["Ciro to Alex" , "6K to 10k SAR" , "Cairo to Alex" ,  "6K to 10k SAR" , "Ciro to Alex"]
    
    @State var active = false
    @State var destination = AnyView(ChatsListView())
    
    @Binding var FilterTag : FilterCases
    @Binding var showFilter:Bool
    

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
                FilterHeaderView(action: {
                    showFilter.toggle()
                })
                ExtractedView(active: $active, destination: $destination, selectedFilterId: $selectedFilterId, filterArray: $filterArray, selectedShipmentId: $selectedShipmentId)
                    .environmentObject(ApprovedShipmentVM)
                }
            }.padding(.top,30)
            
            HStack{
                Spacer()
                Button(action: {
//                    ApprovedShipmentVM.lat = 29.5
//                    ApprovedShipmentVM.lang = 30.5
//                    ApprovedShipmentVM.fromCityId = 2
//                    ApprovedShipmentVM.toCityId = 5
//                    ApprovedShipmentVM.fromDate = Date()
//                    ApprovedShipmentVM.toDate = Date()
//                    ApprovedShipmentVM.shipmentTypesIds = [2,4,5]
//                    ApprovedShipmentVM.GetFilteredShipments()
                    active = true
                    destination = AnyView (ChatsListView())
                }, label: {
                    Image("floatingchat")
                })
            }.padding()
        }
        .onAppear(perform: {
            selectedShipmentId = 0
//            DispatchQueue.main.async {
            ApprovedShipmentVM.GetApprovedShipment()
            ApprovedShipmentVM.GetFilteredShipments()
//            }
        })

        .onChange(of: selectedShipmentId, perform: {newval in
                active = true
                destination = AnyView (DetailsView(shipmentId: selectedShipmentId))
        })

        NavigationLink(destination: destination,isActive:$active , label: {
        })

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(FilterTag: .constant(.Menu), showFilter: .constant(false))
        HomeView(FilterTag: .constant(.Menu), showFilter: .constant(false))
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
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
                    ForEach(0 ..< filterArray.count) { filterItem in
                        FilterView(delete: filterItem != selectedFilterId , filterTitle: filterArray[filterItem] , D: {
                        })
                    }
                }.padding()
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
            }.overlay(content: {
                // showing loading indicator
                ActivityIndicatorView(isPresented: $ApprovedShipmentVM.isLoading)
            })
        }
   
    }
}
