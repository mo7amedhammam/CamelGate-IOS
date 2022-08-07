//
//  GarageView.swift
//  Camel Gate
//
//  Created by wecancity on 21/07/2022.
//

import SwiftUI

struct GarageView: View {
    @State private var selectedFilterId : Int?
    private var filterArray = ["Ciro to Alex" , "6K to 10k SAR" , "Cairo to Alex" ,  "6K to 10k SAR" , "Ciro to Alex"]
    @State var active = false
    @State var selectedShipmentId = 0

    @State var destination = AnyView(DetailsView(shipmentId: 0))
    var body: some View {
        ZStack{
            VStack {
                Spacer().frame(height: 145 )
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
            TitleBar(Title: "Garage Shipments", navBarHidden: true, trailingButton: .filterButton, applyStatus: .applyed,subText: "Applied"  ,trailingAction: {
            })
        }
        NavigationLink(destination: destination,isActive:$active , label: {
        })
    }
}

struct GarageView_Previews: PreviewProvider {
    static var previews: some View {
        GarageView()
    }
}
