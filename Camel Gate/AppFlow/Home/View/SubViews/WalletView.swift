//
//  WalletView.swift
//  Camel Gate
//
//  Created by wecancity on 21/07/2022.
//

import SwiftUI

struct WalletView: View {
    var body: some View {
        HStack{
            ZStack(alignment: .leading ){
                Image("ic_back_wallet").resizable().scaledToFit()
                VStack(spacing: 8 ){
                    Image("ic_wallet")
                    Text("Wallet").foregroundColor(Color.white.opacity(0.7))
                    Text("12,400").foregroundColor(Color.white)
                }.padding()
            }.frame(height: 140)
            ZStack(alignment: .leading ){
                VStack(spacing: 0 ){
                    HStack{
                        Image("ic_car_track")
                        VStack(alignment: .leading ){
                            Text("21").foregroundColor(Color(#colorLiteral(red: 0.356864363, green: 0.3568614721, blue: 0.2826236188, alpha: 1)))
                                .font(.custom("SFUIText-Bold", fixedSize: 20))
                            Text("Upcoming Trips")
                                .foregroundColor(Color(#colorLiteral(red: 0.356864363, green: 0.3568614721, blue: 0.2826236188, alpha: 1)))
                                .font(.custom("SFUIText-Medium", fixedSize: 12))
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(height: 60)
                    Color(#colorLiteral(red: 0.9281044006, green: 0.9126986861, blue: 0.9479321837, alpha: 1)).frame(height: 2)
                    HStack{
                        Image("ic_money")
                        VStack(alignment: .leading ){
                            Text("6,700").foregroundColor(Color(#colorLiteral(red: 0.356864363, green: 0.3568614721, blue: 0.2826236188, alpha: 1)))
                                .font(.custom("SFUIText-Bold", fixedSize: 20))
                            Text("This Month Money")
                                .foregroundColor(Color(#colorLiteral(red: 0.356864363, green: 0.3568614721, blue: 0.2826236188, alpha: 1)))
                                .font(.custom("SFUIText-Medium", fixedSize: 12))
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(height: 60)
                }
            }
            .background(Color.white)
            .clipped()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color("Base_Color"), lineWidth: 0.2)
            )
            .cornerRadius(12)
            .shadow(color: Color("Base_Color").opacity(0.08), radius: 3.0 , x: 0, y: 4)
        }.padding()
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
    }
}
