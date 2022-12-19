//
//  ShipmentRateCell.swift
//  Camel Gate
//
//  Created by wecancity on 24/07/2022.
//

import SwiftUI

struct ShipmentRateCell: View {
    var language = LocalizationService.shared.language

    
    var rate = DriverRatesModel.init(id: 2954, rate: 5, shipmentCode: "SH-08122022-2", date: "2022-12-08T16:26:33.2233445")
    @State var active = false
    @State var destination = AnyView(ChatsListView())
    @EnvironmentObject var environments : camelEnvironments
    var body: some View {
        ZStack {
            VStack{
                HStack{
                    Image("truck")
                        .resizable()
                        .frame(width: 35, height: 30)
                    
                    VStack(alignment:.leading){
                        Text(rate.shipmentCode ?? "")
                            .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)
                            .foregroundColor(Color("blueColor"))
                        HStack{
                            StarsView(rating: Float(rate.rate ?? 0))
                            
                            Spacer()
                            Text(ConvertStringDate(inp: rate.date ?? "",FormatFrom:"yyyy-MM-dd'T'HH:mm:ss.SS",FormatTo:  language.rawValue == "en" ? "dd/MM/yyyy":"yyyy/MM/dd"))
                                .font(Font.camelfonts.Reg11)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.leading,2)
                }
                .padding()
                Button(action: {
//                    DispatchQueue.main.async{
                        destination = AnyView (DetailsView(shipmentId: rate.id ?? 0, CommingFromWallet: true).environmentObject(environments))
                    active = true
//                    }
                }, label: {
                    HStack {
                        Text("Shipment_Details".localized(language))
                            .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)
                            .foregroundColor(Color("blueColor"))
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height:15)
                    .padding()
                    .foregroundColor(.white)
                    .background(
                        .gray.opacity(0.5)
                    )
                    .cornerRadius(12)
                    .padding(.horizontal, 20)
                    .padding(.bottom)
                })
                
            }
            .background(Color.white)
        }
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

        .cornerRadius(12)
        .padding(.horizontal)
        .shadow(radius: 4)
        NavigationLink(destination: destination,isActive:$active , label: {
        })
        
    }
}

struct ShipmentRateCell_Previews: PreviewProvider {
    static var previews: some View {
        ShipmentRateCell()
    }
}
