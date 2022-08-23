//
//  tripCellView.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 7/23/22.
//

import SwiftUI

struct tripCellView: View {
    var language = LocalizationService.shared.language
    @Binding var shipmentModel:ShipmentModel
    @Binding var selecteshipmentId:Int

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
                                VStack{
                                    Image("ic_ship_box")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 90)
//                                        .overlay(
//                                            RoundedRectangle(cornerRadius: 8)
//                                                .stroke(Color(#colorLiteral(red: 0.8797428608, green: 0.8797428012, blue: 0.8797428608, alpha: 1)).opacity(0.60), lineWidth: 2.0)
//
//                                        )
//                                        .cornerRadius(8)
                                        .padding(.horizontal,8)
                                        .padding(.top,15)
//                                        .offset(y:25)

                                    Spacer()
                                    VStack(){
                                        HStack(alignment:.bottom, spacing: 3){
                                            Text("\(shipmentModel.lowestOffer ?? 1200)").foregroundColor(Color.white)
                                                .font(Font.camelfonts.Reg20)
                                                .fontWeight(.medium)

                                            Text("SAR".localized(language)).foregroundColor(Color.white.opacity(0.99))
                                                .font(Font.camelfonts.SemiBold14)
                                        }
                                        Text("LowestOffer".localized(language)).foregroundColor(Color.white.opacity(0.9))
                                            .font(Font.camelfonts.Reg14)
                                    }
//                                    .padding(.horizontal)
                                        .padding(.bottom)
                                    
                                }
                            }.background(
                                Image("ic_tripCell_purple")
                                    .resizable()
                            )
//                                .padding(.vertical,0)
//                            .frame(height: 100)
                            Spacer()
                            HStack{
                                Text("\(shipmentModel.offersCount ?? 0)")
                                    .foregroundColor(Color.black.opacity(0.7))
                                Text("Offers".localized(language))                            .foregroundColor(.secondary)

                            }
                        }
                        .frame(height: 150)
                        .offset( y: -20)
                        Spacer()
                        VStack{
                            VStack {
                                HStack{
                                    Image("ic_dark_truck")
                                        .renderingMode(.template)
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(Color.black.opacity(0.5))

                                    Text("Distance_:_".localized(language))
                                        .foregroundColor(.secondary)
                                        .font(Font.camelfonts.Reg14)
                                    Text("\( String(format: "%.1f", shipmentModel.totalDistance ?? 22.00)) "+"KM".localized(language))
                                        .foregroundColor(.black.opacity(0.7))
                                        .font(Font.camelfonts.Reg14)
                                    Spacer()
                                }
                                HStack{
                                    Image("stargray")
                                        .renderingMode(.template)
                                        .resizable()
                                        .frame(width: 18, height: 18)
                                        .foregroundColor(Color.black.opacity(0.5))
                                    Text("Company_Rate_:_".localized(language))
                                        .foregroundColor(.secondary)
                                        .font(Font.camelfonts.Reg14)
                                    Text("\(shipmentModel.companyRate ?? 0)/5")
                                        .foregroundColor(.black.opacity(0.7))
                                        .font(Font.camelfonts.Reg14)
                                    Spacer()
                                }
                            }
                            HStack {
                                HStack{
                                    VStack{
                                        Image("ic_pin_purple")
                                        Image("ic_line")
                                        Image("ic_pin_orange")
                                    }
                                    VStack(spacing: 20 ){
                                        VStack(alignment: .leading){
                                            Text(shipmentModel.fromCityName ?? "Giza").foregroundColor(Color("Base_Color"))
                                                .font(Font.camelfonts.SemiBold18)
                  
                                            HStack {
                                                Text(ConvertStringDate(inp:shipmentModel.shipmentDateFrom ?? "2022-12-13T12:00:00" ,FormatFrom:"yyyy-MM-dd'T'h:mm:ss",FormatTo:"dd/MM/yyyy"))

                                                
                                                Text(ConvertStringDate(inp:shipmentModel.shipmentDateFrom ?? "2022-12-13T12:00:00" ,FormatFrom:"yyyy-MM-dd'T'h:mm:ss",FormatTo:". h:mm a"))
                                                    .foregroundColor(.secondary)
                                                
                                            }        .font(Font.camelfonts.Reg14)
                                            

                                        }
                                        VStack(alignment: .leading){
                                            Text(shipmentModel.toCityName ??  "Alexandria").foregroundColor(Color("Second_Color"))
                                                .font(Font.camelfonts.SemiBold18)

                                            HStack {
                                                Text(ConvertStringDate(inp:shipmentModel.shipmentDateTo ?? "2023-01-03T00:00:00" ,FormatFrom:"yyyy-MM-dd'T'hh:mm:ss",FormatTo:"dd/MM/yyyy"))
                                                
                                                Text(ConvertStringDate(inp:shipmentModel.shipmentDateTo ?? "2023-01-03T00:00:00" ,FormatFrom:"yyyy-MM-dd'T'hh:mm:ss",FormatTo:". hh:mm a"))
                                                    .foregroundColor(.secondary)
                                                
                                            }    .font(Font.camelfonts.Reg14)
                                            
                                        }
                                    }
                                }
                                Spacer()
                                Text("")
                            }
                        }.padding(.top , -10)
                    }.padding()
                        .overlay(content: {
                            if shipmentModel.driverOfferStatusID != nil {
                            
                            VStack {
                                HStack(alignment:.top){
                                    Text(shipmentModel.driverOfferStatusName ?? "Accepted")
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                        .padding(.vertical,5)
                                    

                                        .background(
                                            RoundedCornersShape(radius: 8, corners: [.topLeft,.bottomRight]).foregroundColor( (shipmentModel.driverOfferStatusID == 1 || shipmentModel.driverOfferStatusID == 4) ? Color(#colorLiteral(red: 0.259, green: 0.812, blue: 0, alpha: 1)):.red))
//                                        .cornerRadius(8)
                                    Spacer()
                                }
                                Spacer()
                            }.offset(y:-15)
                            }
                        })
                }
                Color(#colorLiteral(red: 0.6138994098, green: 0.6338609457, blue: 0.6889666915, alpha: 1)).frame(height: 1)
                ZStack{
                    Color(#colorLiteral(red: 0.6920476556, green: 0.7039827704, blue: 0.747436285, alpha: 1)).opacity(0.16)
                    HStack(spacing: 10){
                        Image("stargray")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color.black.opacity(0.7))
//                        HStack{
//                            Text("6").foregroundColor(Color.black)
                        Text("Driver_Rate_:_".localized(language)).foregroundColor(.secondary)                        .font(Font.camelfonts.Light16)

                        Text("\(shipmentModel.lowestOfferDriverRate ?? 0)/5")
                            .foregroundColor(Color.black.opacity(0.7))
                            Spacer()
                        Text("\(shipmentModel.offersCount ?? 0)")
                            .foregroundColor(Color.black.opacity(0.7))
                        Text("Offers".localized(language)).foregroundColor(.secondary)
                            .font(Font.camelfonts.Light16)
//                                .fontWeight(.ultraLight)

                            Button(action: {}) {
                                Image("ic_share")
                            }
//                        }
                    }
                    .padding(.horizontal)
                }
                .frame(height: 40)
            }
        }
        .onTapGesture {
            selecteshipmentId = shipmentModel.id ?? 0
        }

        .frame(height: 240)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(#colorLiteral(red: 0.6138994098, green: 0.6338609457, blue: 0.6889666915, alpha: 1)), lineWidth: 2.0)
        )
        .cornerRadius(10)
    }
}

struct tripCellView_Previews: PreviewProvider {
    static var previews: some View {
        tripCellView( shipmentModel: .constant(ShipmentModel.init()), selecteshipmentId: .constant(0))
    }
}



