//
//  HomeView.swift
//  Camel Gate
//
//  Created by wecancity on 21/07/2022.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack{
                Image("homeTopMask")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .offset( y: -30)
            VStack {
                HeaderView()
                WalletView()
            }
            .offset( y: 30)

        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
