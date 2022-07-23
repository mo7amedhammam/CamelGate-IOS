//
//  HomeView.swift
//  Camel Gate
//
//  Created by wecancity on 21/07/2022.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedFilterId : Int?
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
            ScrollView {
                VStack(spacing: 0){
                    HeaderView()
                    WalletIcon()
                    ShipView()
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
                            }
                        }
                    }
                }
                .offset( y: 30)
            }
        }.navigationBarHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
