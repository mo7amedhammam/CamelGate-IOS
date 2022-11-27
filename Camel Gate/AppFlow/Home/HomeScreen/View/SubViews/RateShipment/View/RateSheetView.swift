//
//  RateSheetView.swift
//  Camel Gate
//
//  Created by wecancity on 26/11/2022.
//

import SwiftUI

struct RateSheetView:View{
    var language = LocalizationService.shared.language
    @EnvironmentObject var environments : camelEnvironments
@State private var index = 1
    var body: some View{
        VStack {
            if index == 1{
            VStack{
//                Spacer()
                Text("Shipment_Done!".localized(language))
                    .font( language.rawValue == "ar" ? Font.camelfonts.SemiBoldAr20:Font.camelfonts.SemiBold20)
                    .frame(width:UIScreen.main.bounds.width)
                    .overlay(
                        HStack{
                        Spacer()
                        Button(action: {
                            environments.ShowRatingSheet.toggle()
                        }, label: {
                            Image(systemName: "x.circle.fill")
                                .font(.title)
                                .foregroundColor(.gray.opacity(0.6))
                        })
//                                .padding()
                    }
                            .padding(.vertical)

                            .padding(.horizontal)
                    )
                    .padding(.top)

                
                Image("rateShipmentIcon")
                    .resizable()
                    .scaledToFit()
                    .frame( height: 100)
                    .padding(.vertical,10)
                
                Text("You_just_have_gained".localized(language)+"1,200_SAR".localized(language))
                    .lineLimit(.bitWidth)

//                NavigationLink(destination:  SendingRateView().environmentObject(environments)   , label: {
                    
                
                Button(action: {
    //                ShowRedirector = false
                    withAnimation{
                    index = 2
                    }
                }, label: {
                    HStack {
                        Text("Rate_The_Company".localized(language))
    .font( language.rawValue == "ar" ? Font.camelfonts.BoldAr14:Font.camelfonts.Bold14)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color("blueColor"))
                    .cornerRadius(12)
                })
                    .frame( height: 60)
                    .padding(.bottom,10)
                    
//                })
                    
            }
            .tag(1)
            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

            .onAppear(perform: {
    index = 1
        })
            
        }else if index == 2{
            SendingRateView()
                .tag(2)
                .environmentObject(environments)
        }
        }
//        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(height:250)
        .padding(.bottom,10)
//        .padding(.top,0)
    }
}

struct RateSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            RateSheetView()
                .environmentObject(camelEnvironments())
        }
    }
}
