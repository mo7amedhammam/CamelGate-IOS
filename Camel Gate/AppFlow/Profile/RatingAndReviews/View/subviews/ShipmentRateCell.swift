//
//  ShipmentRateCell.swift
//  Camel Gate
//
//  Created by wecancity on 24/07/2022.
//

import SwiftUI

struct ShipmentRateCell: View {
    var body: some View {
        ZStack {
            VStack{
                HStack{
                    Image("truck")
                        .resizable()
                        .frame(width: 35, height: 30)
                    
                    VStack(alignment:.leading){
                        Text("#DRE132312")
                                                                           .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)

                            .foregroundColor(Color("blueColor"))
                        HStack{
                            StarsView(rating: 4.5)
                            
                            Spacer()
                            Text("26/02/2019")
                                .font(Font.camelfonts.Reg11)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.leading,2)
                }
                .padding()
                Button(action: {
                    DispatchQueue.main.async{
                        // Action
                    }
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
    }
}

struct ShipmentRateCell_Previews: PreviewProvider {
    static var previews: some View {
        ShipmentRateCell()
    }
}
