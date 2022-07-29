//
//  HomeView.swift
//  Camel Gate
//
//  Created by wecancity on 21/07/2022.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedFilterId : Int?
    @State var goToShipmentDetails:Bool = false
    private var filterArray = ["Ciro to Alex" , "6K to 10k SAR" , "Cairo to Alex" ,  "6K to 10k SAR" , "Ciro to Alex"]
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
                ShipView().shadow(radius: 5)
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
                                goToShipmentDetails = true
                            }
                        }
                    }
                }
            }.padding(.top,30)
        }.navigationBarHidden(true)
        
        NavigationLink(destination: DetailsView(),isActive:$goToShipmentDetails , label: {
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
