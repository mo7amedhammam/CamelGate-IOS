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
    @State  var filterArray : [String] = []
    
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
                    active = true
                    destination = AnyView (ChatsListView())
                }, label: {
                    Image("floatingchat")
                })
            }.padding()
        }
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
                        })
                    }
                    if ApprovedShipmentVM.fromDateStr != ""{
                        FilterView(delete: true, filterTitle: "\(ApprovedShipmentVM.fromDate.DateToStr(format: "dd/MM/yyyy")) to \(ApprovedShipmentVM.toDate.DateToStr(format: "dd/MM/yyyy"))", D: {
                            ApprovedShipmentVM.fromDateStr = ""
                            ApprovedShipmentVM.toDateStr = ""
                        })
                    }
                    if ApprovedShipmentVM.shipmentTypesIds != []{
                        FilterView(delete: true, filterTitle: "\(ApprovedShipmentVM.shipmentTypesNames.joined(separator: ", "))", D: {
                            ApprovedShipmentVM.shipmentTypesIds = []
                            ApprovedShipmentVM.shipmentTypesNames = []
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
