//
//  RedirectToGMaps.swift
//  Camel Gate
//
//  Created by wecancity on 16/08/2022.
//

import Foundation
import SwiftUI

struct RedirectToGMaps:View{
    @Binding var ShowRedirector:Bool
    var Long:Double
    var Lat:Double
@State var Address = ""
    var body: some View{
        VStack{
            Spacer()
            Text("Delivery_Location".localized(language))
                .font(Font.camelfonts.Bold20)
                .frame(width:UIScreen.main.bounds.width)
                .overlay(HStack{
                    Spacer()
                    Button(action: {
                        ShowRedirector.toggle()
                    }, label: {
                        Image(systemName: "x.circle.fill")
                            .font(.title)
                            .foregroundColor(.gray.opacity(0.6))
                    })
                }
                            .padding()
                )
            HStack{
                Image("ic_pin_orange")
                    .resizable()
                    .frame(width: 50, height: 50)
                Text(Helper.getUserAddress())
                    .lineLimit(.bitWidth)
            }
            Button(action: {

                Helper.openGoogleMap(longitude: Long, latitude: Lat)
                ShowRedirector = false
            }, label: {
                HStack {
                    Text("Redirect_to_Location".localized(language))
                        .font(Font.camelfonts.Bold18)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color("blueColor"))
                .cornerRadius(12)
            })
                .frame( height: 60)
                .padding(.bottom,10)
        }.onAppear(perform: {
            print(Long)
            print(Lat)
            DispatchQueue.main.async {
                Address = getAddressFromLatLon(Latitude:"\(Lat)" ,withLongitude:"\(Long)")

            }
            
        })
            .onChange(of: Long, perform: {newval in
                DispatchQueue.main.async {
                    Address = getAddressFromLatLon(Latitude:"\(Lat)" ,withLongitude:"\(newval)")
                }

        })
            .onChange(of: Lat, perform: {newval in
                DispatchQueue.main.async {
                    Address = getAddressFromLatLon(Latitude:"\(newval)" ,withLongitude:"\(Long)")
                }

        })
        
//        .frame(height:180)
    }
}

struct RedirectToGMaps_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            RedirectToGMaps(ShowRedirector: .constant(true), Long: 29.2, Lat: 30.5)
        }
    }
}
