//
//  WalletView.swift
//  Camel Gate
//
//  Created by wecancity on 21/07/2022.
//

import SwiftUI

struct WalletView: View {
    var body: some View {
        ZStack{
         
            TitleBar(Title: "Wallet", navBarHidden: true, trailingButton: .filterButton ,trailingAction: {
            })
        }
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
    }
}
