//
//  WalletViewCell.swift
//  Camel Gate
//
//  Created by wecancity on 20/10/2022.
//

import SwiftUI

struct WalletViewCell : View {
    var body: some View {
        ZStack{
            VStack{
                Color(#colorLiteral(red: 0.3571086526, green: 0.2268399, blue: 0.5710855126, alpha: 0.09))
                    .frame(height: 1)
                HStack{
                    ZStack{
                        Color(#colorLiteral(red: 0.2599548995, green: 0.8122869134, blue: 0.005582589656, alpha: 1))
                        Text("25 May").font(Font.camelfonts.Bold14).foregroundColor(Color.white)
                        
                    }.frame(width: 80, height: 80).cornerRadius(10)
                    VStack(alignment : .leading ){
                        HStack{
                            Text("7,600")
                            Text("SAR")
                            Text("Gained").foregroundColor(Color(#colorLiteral(red: 0.2599548995, green: 0.8122869134, blue: 0.005582589656, alpha: 1)))
                        }
                        HStack{
                            Image("ic_calender")
                            Text("14/02/2022")
                            Spacer()
                            Button(action: {}) {
                                ZStack{
                                    Color(#colorLiteral(red: 0.92371732, green: 0.9792584777, blue: 0.9036960006, alpha: 1))
                                    Text("View Shipment").foregroundColor(Color(#colorLiteral(red: 0.2599548995, green: 0.8122869134, blue: 0.005582589656, alpha: 1))).cornerRadius(10)
                                }
                            }
                            
                        }
                    }
                }
                Color(#colorLiteral(red: 0.3571086526, green: 0.2268399, blue: 0.5710855126, alpha: 0.09))
                    .frame(height: 1)
            }.padding()
        }
    }
}
struct WalletViewCell_Previews: PreviewProvider {
    static var previews: some View {
        WalletViewCell()
    }
}
