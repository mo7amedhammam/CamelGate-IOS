//
//  ShipmentsView.swift
//  Camel Gate
//
//  Created by wecancity on 21/07/2022.
//

import SwiftUI

struct ShipmentsView: View {
    var body: some View {
        ZStack{
         
            
            
            TitleBar(Title: "Shipments", SubTitle: "", navBarHidden: true, trailingButton: .filterButton, subText: "55" ,trailingAction: {
            })
        }
    }
}

struct ShipmentsView_Previews: PreviewProvider {
    static var previews: some View {
        ShipmentsView()
    }
}
