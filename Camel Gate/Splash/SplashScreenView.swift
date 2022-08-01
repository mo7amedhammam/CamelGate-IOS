//
//  SplashScreenView.swift
//  Camel Gate
//
//  Created by wecancity on 01/08/2022.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {}
        .frame( maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("splashScreen")
                .resizable())
        .ignoresSafeArea()
    }
    
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}