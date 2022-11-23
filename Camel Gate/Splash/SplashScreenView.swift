//
//  SplashScreenView.swift
//  Camel Gate
//
//  Created by wecancity on 01/08/2022.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {

        }
        .frame( maxWidth: .infinity, maxHeight: .infinity)
        .background(
//            Image("splashScreen")
//                .resizable()
//            AnimatingGif(isPresented: .constant(true), jsonFileName: "4 - 5.lottie")

//            "newSplash9-19" , "3-4.lottie" , "4 - 5.lottie" , "9 - 16.lottie" , "9 - 19,5.lottie"
            LottieView(lottieFile: "newSplash")
//                .scaleEffect(0.7)
//                .aspectRatio( contentMode: .fit)
            
//        .ignoresSafeArea()
//                .frame( maxWidth: .infinity, maxHeight: .infinity)

        )
        .ignoresSafeArea()

            //        .onAppear(perform: {
//            for family in UIFont.familyNames.sorted() {
//                let names = UIFont.fontNames(forFamilyName: family)
//                print("Family: \(family) Font names: \(names)")
//            }
//
//        })
    }
    
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
