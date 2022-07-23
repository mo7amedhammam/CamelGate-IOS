//
//  tripCellView.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 7/23/22.
//

import SwiftUI

struct tripCellView: View {
    var body: some View {
        ZStack{
            Color.white
            VStack(spacing: 0){
                Color(#colorLiteral(red: 0.3697291017, green: 0.2442134917, blue: 0.5784509778, alpha: 1)).frame(height : 10)
                ZStack {
                    VStack {
                        Text("")
                        Spacer()
                        HStack {
                            Text("")
                            Spacer()
                            Image("ic_gray_camel")
                        }.padding()
                    }
                    HStack{
                        VStack {
                            ZStack{
                                Image("ic_tripCell_purple")
                                VStack{
                                    Image("ic_ship_box")
                                        .resizable()
                                        .frame(width: 100, height: 70)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color(#colorLiteral(red: 0.8797428608, green: 0.8797428012, blue: 0.8797428608, alpha: 1)).opacity(0.60), lineWidth: 2.0)
                                        )
                                        .cornerRadius(8)
                                    Spacer()
                                    VStack(spacing: 3){
                                        HStack(spacing: 3){
                                            Text("1,200").foregroundColor(Color.white)
                                            Text("SAR").foregroundColor(Color.white).fontWeight(.bold)
                                        }
                                        Text("Lowest Offer").foregroundColor(Color.white)
                                            .font(.custom("SFUIText-Medium", fixedSize: 12))
                                    }.padding()
                                }
                            }.frame(height: 109)
                            Spacer()
                            HStack{
                                Text("240").foregroundColor(Color.black)
                                    .font(.custom("SFUIText-Medium", fixedSize: 12))
                                Text("Offers").foregroundColor(Color.gray)
                                    .font(.custom("SFUIText-Medium", fixedSize: 12))
                            }
                        }.frame(height: 150)
                        Spacer()
                        VStack{
                            HStack{
                                Image("ic_dark_truck")
                                Text("Distance : ")
                                    .foregroundColor(Color(#colorLiteral(red: 0.4320293069, green: 0.4300495386, blue: 0.3618791103, alpha: 1)))
                                    .font(.custom("SFUIText-Regular", fixedSize: 11.0))
                                Text("240 KM")
                                    .foregroundColor(Color(#colorLiteral(red: 0.4320293069, green: 0.4300495386, blue: 0.3618791103, alpha: 1)))
                                    .font(.custom("SFUIText-Medium", fixedSize: 12.0))
                                Spacer()
                                Button(action: {}) {
                                    Image("ic_share")
                                }
                            }
                            HStack {
                                HStack{
                                    VStack{
                                        Image("ic_pin_purple")
                                        Image("ic_line")
                                        Image("ic_pin_orange")
                                    }
                                    VStack(spacing: 30 ){
                                        VStack(alignment: .leading){
                                            Text("Giza").foregroundColor(Color("Base_Color"))
                                            HStack{
                                                Text("22/05/2022").font(.custom("SFUIText-Regular", fixedSize: 11.0))
                                                Text(".  1:30 AM").font(.custom("SFUIText-Regular", fixedSize: 11.0))
                                            }
                                        }
                                        VStack(alignment: .leading){
                                            Text("Alexandria").foregroundColor(Color("Second_Color"))
                                            HStack{
                                                Text("23/05/2022").font(.custom("SFUIText-Regular", fixedSize: 11.0))
                                                Text(".  4:30 PM")
                                                    .font(.custom("SFUIText-Regular", fixedSize: 11.0))
                                            }
                                        }
                                    }
                                }
                                Spacer()
                                Text("")
                            }
                        }.padding(.top , -40)
                    }.padding()
                }
                Color(#colorLiteral(red: 0.6138994098, green: 0.6338609457, blue: 0.6889666915, alpha: 1)).frame(height: 1)
                ZStack{
                    Color(#colorLiteral(red: 0.6920476556, green: 0.7039827704, blue: 0.747436285, alpha: 1)).opacity(0.16)
                    HStack(spacing: 10){
                        Image("ic_box")
                        HStack{
                            Text("6").foregroundColor(Color.black)
                                .font(.custom("SFUIText-Medium", fixedSize: 12))
                            Text("Tons  .").foregroundColor(Color.gray)
                                .font(.custom("SFUIText-Medium", fixedSize: 12))
                            Text("Cleaning Materials").foregroundColor(Color.gray)
                                .font(.custom("SFUIText-Medium", fixedSize: 12))
                        }
                        Spacer()
                    }.padding()
                }
                .frame(height: 40)
            }
        }
        .frame(height: 231)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(#colorLiteral(red: 0.6138994098, green: 0.6338609457, blue: 0.6889666915, alpha: 1)), lineWidth: 2.0)
        )
        .cornerRadius(10)
        .padding()
    }
}

struct tripCellView_Previews: PreviewProvider {
    static var previews: some View {
        tripCellView()
    }
}
