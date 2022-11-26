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
    @EnvironmentObject var imageVM : imageViewModel
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
//                            Image("ic_gray_camel")
                            
                        }.padding()
                    }
                    HStack{
                        VStack {
                            ZStack{
                                VStack{
//                                    Image("ic_ship_box")
                                    AsyncImage(url: URL(string: Constants.baseURL + "\(shipmentModel.imageURL ?? "")".replacingOccurrences(of: "\\",with: "/"))) { image in
                                        image.resizable()
                                    } placeholder: {
                                        Image("cover_vector")
                                            .resizable()
                                            .cornerRadius(8)
         
                                    }
//                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 90)
//                                        .overlay(
//                                            RoundedRectangle(cornerRadius: 8)
//                                                .stroke(Color(#colorLiteral(red: 0.8797428608, green: 0.8797428012, blue: 0.8797428608, alpha: 1)).opacity(0.60), lineWidth: 2.0)
//
//                                        )
                                        .cornerRadius(8)
                                        .padding(.horizontal,8)
                                        .padding(.top,15)
//                                        .offset(y:25)

                                    Spacer()
                                    VStack(){
                                        HStack(alignment:.bottom, spacing: 3){
                                            Text("\(shipmentModel.lowestOffer ?? 1200)").foregroundColor(Color.white)
                                                .font( language.rawValue == "ar" ? Font.camelfonts.BoldAr16:Font.camelfonts.Bold18)
                                                .fontWeight(.medium)

                                            Text("SAR".localized(language)).foregroundColor(Color.white.opacity(0.99))
                                                .font( language.rawValue == "ar" ? Font.camelfonts.SemiBoldAr12:Font.camelfonts.SemiBold12)
                                        }
                                        Text("LowestOffer".localized(language)).foregroundColor(Color.white.opacity(0.9))
                                                .font( language.rawValue == "ar" ? Font.camelfonts.RegAr12:Font.camelfonts.Reg12)
                                                .padding(.top,-4)

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
                                Text("Offers".localized(language))
                                    .foregroundColor(.secondary)

                            }
                            .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)

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
                                        .frame(width: 18, height: 18)
                                        .foregroundColor(Color.black.opacity(0.4))

                                    Text("Distance_:_".localized(language))
                                        .foregroundColor(.secondary)
                                        .font( language.rawValue == "ar" ? Font.camelfonts.RegAr11:Font.camelfonts.Reg11)

                                    Text("\( String(format: "%.1f", shipmentModel.totalDistance ?? 22.00)) "+"KM".localized(language))
                                        .foregroundColor(.black.opacity(0.7))
                                        .font( language.rawValue == "ar" ? Font.camelfonts.SemiBoldAr11:Font.camelfonts.SemiBold11)
                                    Spacer()
                                }
                                HStack{
                                    Image("stargray")
                                        .renderingMode(.template)
                                        .resizable()
                                        .frame(width: 16, height: 16)
                                        .foregroundColor(Color.black.opacity(0.4))
                                    Text("Company_Rate_:_".localized(language))
                                        .foregroundColor(.secondary)
                                        .font( language.rawValue == "ar" ? Font.camelfonts.RegAr11:Font.camelfonts.Reg11)

                                    Text("\(String(format: "%.1f", shipmentModel.companyRate ?? 0)) / 5")
                                        .foregroundColor(.black.opacity(0.7))
                                        .font( language.rawValue == "ar" ? Font.camelfonts.SemiBoldAr11:Font.camelfonts.SemiBold11)

                                    Spacer()
                                }
                            }
                            HStack {
                                HStack{
                                    VStack{
                                        Image("ic_pin_purple")
                                            .resizable()
                                            .frame(width: 30, height: 30)

                                        Image("ic_line")
                                            .resizable()
                                            .frame(width: 1, height: 15)
                                            .padding(.vertical,-10)

                                        Image("ic_pin_orange")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                    }
                                    VStack(alignment:.leading, spacing: 15 ){
                                        VStack(alignment: .leading){
                                            Text(shipmentModel.fromCityName ?? "Giza")
                                                .foregroundColor(Color("Base_Color"))
                                            .font( language.rawValue == "ar" ? Font.camelfonts.SemiBoldAr16:Font.camelfonts.SemiBold16)
                  
                                            HStack {
                                                Text(ConvertStringDate(inp:shipmentModel.shipmentDateFrom ?? "2022-12-13T12:00:00" ,FormatFrom:"yyyy-MM-dd'T'HH:mm:ss",FormatTo:"dd / MM / yyyy"))

                                                Text(ConvertStringDate(inp:shipmentModel.shipmentDateFrom ?? "2022-12-13T12:00:00" ,FormatFrom:"yyyy-MM-dd'T'HH:mm:ss",FormatTo:". h:mm a"))
                                                    .foregroundColor(.secondary)
                                            }
                                            .padding(.top,-6)
                                            .font( language.rawValue == "ar" ? Font.camelfonts.RegAr12:Font.camelfonts.Reg12)
                                        }
                                        VStack(alignment: .leading){
                                            Text(shipmentModel.toCityName ??  "Alexandria").foregroundColor(Color("Second_Color"))
                                                .font( language.rawValue == "ar" ? Font.camelfonts.SemiBoldAr16:Font.camelfonts.SemiBold16)

                                            HStack {
                                                Text(ConvertStringDate(inp:shipmentModel.shipmentDateTo ?? "2023-01-03T00:00:00" ,FormatFrom:"yyyy-MM-dd'T'HH:mm:ss",FormatTo:"dd / MM / yyyy"))
                                                
                                                Text(ConvertStringDate(inp:shipmentModel.shipmentDateTo ?? "2023-01-03T00:00:00" ,FormatFrom:"yyyy-MM-dd'T'HH:mm:ss",FormatTo:". hh:mm a"))
                                                    .foregroundColor(.secondary)
                                                
                                            }
                                            .padding(.top,-6)
                                            .font( language.rawValue == "ar" ? Font.camelfonts.RegAr12:Font.camelfonts.Reg12)

                                            
                                        }
                                    }
                                }
                                Spacer()
                                Text("")
                            }
                        }.padding(.top , -30)
                    }.padding()
                        .overlay(content: {
                            if shipmentModel.driverOfferStatusID != nil {
                            
                            VStack {
                                HStack(alignment:.top){
                                    Text(shipmentModel.driverOfferStatusName?.replacingOccurrences(of: "  ", with: "") ?? "Accepted")
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                        .padding(.vertical,5)
                                        .font( language.rawValue == "ar" ? Font.camelfonts.SemiBoldAr11:Font.camelfonts.SemiBold11)

                                        .background(
                                            RoundedCornersShape(radius: 8, corners: language.rawValue == "ar" ? [.topRight, .bottomLeft]:[.topLeft,.bottomRight]).foregroundColor( (shipmentModel.driverOfferStatusID == 1 || shipmentModel.driverOfferStatusID == 4) ? Color(#colorLiteral(red: 0.259, green: 0.812, blue: 0, alpha: 1)):.red))
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
                            .frame(width: 15, height: 15)
                            .foregroundColor(Color.black.opacity(0.7))

                        Text("Driver_Rate_:_".localized(language)).foregroundColor(.secondary)

                        Text("\(shipmentModel.lowestOfferDriverRate ?? 0) / 5")
                            .foregroundColor(Color.black.opacity(0.7))
                            Spacer()
                        Text("\(shipmentModel.offersCount ?? 0)")
                            .foregroundColor(Color.black.opacity(0.7))
                        Text("Offers".localized(language)).foregroundColor(.secondary)

//                            Button(action: {}) {
//                                Image("ic_share")
//                                    .resizable()
//                                    .frame(width: 20, height: 20)
//                            }

                    }
                    .font( language.rawValue == "ar" ? Font.camelfonts.RegAr12:Font.camelfonts.Reg12)
                    .padding(.horizontal)
                }
                .frame(height: 40)
            }
        }
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

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



