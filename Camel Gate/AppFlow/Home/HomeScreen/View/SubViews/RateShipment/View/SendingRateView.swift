//
//  SendingRateView.swift
//  Camel Gate
//
//  Created by wecancity on 26/11/2022.
//

import SwiftUI

struct SendingRateView:View{
    var language = LocalizationService.shared.language
    @EnvironmentObject var environments : camelEnvironments
    @State var rate = 0

    var body: some View{
            VStack{
                Spacer()
                Text("Shipment_Done2!".localized(language))
                    .font( language.rawValue == "ar" ? Font.camelfonts.SemiBoldAr20:Font.camelfonts.SemiBold20)
                    .frame(width:UIScreen.main.bounds.width)
                    .overlay(HStack{
                        Spacer()
                        Button(action: {
                            environments.ShowRatingSheet.toggle()
                        }, label: {
                            Image(systemName: "x.circle.fill")
                                .font(.title)
                                .foregroundColor(.gray.opacity(0.6))
                        })
                    }
                                .padding()
                    )
              
                
                VStack {
                    Text("You_just_finished_shipment".localized(language))
                        .padding(.bottom,3)
                      
                    Text("#D232eR3959640")
                        .bold()
                
                }  .lineLimit(.bitWidth)
                    .multilineTextAlignment(.center)
                    .font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
                    .padding(.top,10)
                
//                VStack{
                HStack(spacing:20){
                    ForEach(0..<5){ num in
                        Button(action: {
                            rate = num+1
                        }, label: {
                            Image(systemName: rate>num ? "star.fill":"star")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 45, height: 45, alignment: .center)
                                .foregroundColor(.yellow)
                        })
                    }
                }
                .background(.white)
                .frame(width:UIScreen.main.bounds.width)
                HStack(){
                    Text("Bad_".localized(language))
 Spacer()
                    Text("Perfect_".localized(language))
                }
                .padding(.bottom,3)
                .font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
                .padding(.horizontal,40)
//                }.padding(.horizontal)
                
                Button(action: {
    //                ShowRedirector = false
                }, label: {
                    HStack {
                        Text("Send_Rate".localized(language))
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
            }
            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

            .onAppear(perform: {
    //            locationVM.lat = "\(Lat)"
    //            locationVM.long = "\(Long)"
    //            locationVM.getAddressFromLatLon()
        })
            .frame(height:250)
            .padding(.bottom,5)
        
//        .frame(height:180)
    }
}

struct SendingRateView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            SendingRateView()
                .environmentObject(camelEnvironments())
        }
    }
}
