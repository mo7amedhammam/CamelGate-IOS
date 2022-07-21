//
//  GarageView.swift
//  Camel Gate
//
//  Created by wecancity on 21/07/2022.
//

import SwiftUI

struct GarageView: View {
    var body: some View {
        ZStack{
         
            TitleBar(Title: "Garage Shipments", SubTitle: "", navBarHidden: true, trailingButton: .filterButton, applyStatus: .applyed,subText: "Applied"  ,trailingAction: {
            })
        }
    }
}

struct GarageView_Previews: PreviewProvider {
    static var previews: some View {
        GarageView()
    }
}
