//
//  HeaderView.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 7/18/22.
//

import SwiftUI
//import CoreLocation

struct HeaderView: View {
    var language = LocalizationService.shared.language

    @State var active = false
    @State var destination = AnyView(NotificationsView())
    @EnvironmentObject var locationVM : LocationAddressVM
    @EnvironmentObject var imageVM : camelEnvironments
    @EnvironmentObject var driverRate : DriverRateViewModel
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: Constants.baseURL + Helper.getDriverimage().replacingOccurrences(of: "\\",with: "/"))) { image in
                image.resizable()
                    .onTapGesture(perform: {
                        imageVM.imageUrl = Constants.baseURL + Helper.getDriverimage().replacingOccurrences(of: "\\",with: "/")
                        imageVM.isPresented = true
                    })
            } placeholder: {
                Image("face_vector")
            }
            .clipShape(Circle())
            .frame(width: 50, height: 50, alignment: .center)
            .overlay(Circle().stroke(.white.opacity(0.7), lineWidth: 4))
            
            VStack(alignment: .leading ){
                HStack{
                    Text(LoginManger.getUser()?.name ?? "")
                        .font( language.rawValue == "ar" ? Font.camelfonts.BoldAr18:Font.camelfonts.Bold18)
                        .foregroundColor(Color.white)
                    HStack(alignment:.center){
                        Text("")
                        Image("ic_star")
                        Text(NSNumber(value: driverRate.DriverRate) , formatter: numberformatter)
                            .font(.camelRegular(of: 14))
                            .foregroundColor(Color.white)
                    }
                    .padding(3.0)
                    .background(Color.white.opacity(0.35))
                    .cornerRadius(8)
                }
                HStack{
                    Image("ic_location")
                    Text(locationVM.Publishedaddress)
                        .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)
                        .foregroundColor(Color.white)
                }
            }
            Spacer()
//            MARK: -- notification Button on Home top --
//            Button(action: {
//                active = true
//                destination = AnyView(NotificationsView())
//            }) {
//                Image("ic_big_notification")
//            }
        }
        .padding()
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: { [self] in
                locationVM.lat = "\(locationVM.lastLocation?.coordinate.latitude ?? 0.0)"
                locationVM.long = "\(locationVM.lastLocation?.coordinate.longitude ?? 0.0)"
                locationVM.getAddressFromLatLon(completion: {address in
                    locationVM.Publishedaddress = address
                })
            })
        })
        NavigationLink(destination: destination,isActive:$active , label: {
        })
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView().environmentObject(camelEnvironments())
            .environmentObject(LocationAddressVM())
            .environmentObject(DriverRateViewModel())
    }
}
