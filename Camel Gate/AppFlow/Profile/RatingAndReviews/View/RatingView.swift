//
//  RatingView.swift
//  Camel Gate
//
//  Created by wecancity on 24/07/2022.
//

import SwiftUI

struct RatingView: View {
    var language = LocalizationService.shared.language
    @StateObject var RatesVM:DriverRatesViewModel = DriverRatesViewModel()
    @EnvironmentObject var OverAllRate : DriverRateViewModel
    @EnvironmentObject var environments : camelEnvironments

    var body: some View {
        ZStack{
            ScrollView{
                VStack(spacing:10) {
                    ForEach(RatesVM.publishedRatesModel,id:\.id){ rate in
                    ShipmentRateCell( rate: rate)
                            .environmentObject(environments)
                    }
//                    .padding(.top)
                }
            }.padding(.top,hasNotch ? 100:115)
            
            if RatesVM.noReviews {
                Text("No_Reviews_To_Show".localized(language))
            }
            
            TitleBar(Title: "Rating_&_Reviews".localized(language), navBarHidden: true, leadingButton: .backButton, IsSubTextRate: true,subText: "\(OverAllRate.DriverRate )".convertedDigitsToLocale(identifier: "en_US"), fielsType: .number, trailingAction: {})
        }
        
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
        
        .overlay(
            ZStack{
            if RatesVM.isAlert{
                CustomAlert(presentAlert: $RatesVM.isAlert,alertType: .error(title: "", message: RatesVM.message, lefttext: "", righttext: "OK".localized(language)),rightButtonAction: {
//                    if RatesVM.activeAlert == .unauthorized{
//                        Helper.logout()
//                        LoginManger.removeUser()
//                        destination = AnyView(SignInView())
//                        active = true
//                    }
                    DispatchQueue.main.async(execute: {
                        RatesVM.isAlert = false
                        RatesVM.isAlert = false
                    })
                })
                }
            }.ignoresSafeArea()
                .edgesIgnoringSafeArea(.all)
                .onChange(of: RatesVM.isAlert, perform: {newval in
                    if newval == true{
                    DispatchQueue.main.async {
                    environments.isError = true
                    }
                    }
                })
                .onAppear(perform: {
                    if environments.isError == false && RatesVM.isAlert == true{
                        environments.isError = true
                    }
                })

        )
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            RatingView()
        }
        ZStack {
            RatingView()
        }.previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
    }
}

