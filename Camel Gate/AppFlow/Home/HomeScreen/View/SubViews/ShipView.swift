//
//  ShipView.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 7/23/22.
//

import SwiftUI

struct ShipView: View {
    @EnvironmentObject var ApprovedShipmentVM:ApprovedShipmentViewModel
    var body: some View {
        VStack(spacing: 0){
            ZStack{
                Image("ic_ship_purple").resizable()
                HStack(spacing: 10){
                    Text("Shipment").foregroundColor(Color.white)
                    Text("#\(ApprovedShipmentVM.publishedapprovedShipmentModel?.code ?? "1215")")
                        .foregroundColor(Color.white)
                    Spacer()
                }
                .font(Font.camelfonts.Med16)
                .padding(.leading)
            }
            .frame(height: 50)
            ZStack{
                Color(#colorLiteral(red: 0.9413323998, green: 0.9409359097, blue: 0.9541043639, alpha: 1))
                VStack {
                    HStack(){
                        VStack(alignment: .leading){
                            Text("Delivery")
                            HStack{
                                Text(
                                    ConvertStringDate(inp:ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentDateTo ?? "2022-08-17T00:00:00",FormatFrom:"yyyy-MM-dd'T'HH:mm:ss",FormatTo:"E. dd/MM/yyyy . h:m aa")
                                )
                            }
                            
                        }
                        .font(Font.camelfonts.Reg16)

                        Spacer()
                        Button(action: {
                            
                            if ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentStatusId == 2{
                                Helper.openGoogleMap(longitude: Double(ApprovedShipmentVM.publishedapprovedShipmentModel?.fromLang ?? 0), latitude: Double(ApprovedShipmentVM.publishedapprovedShipmentModel?.fromLat ?? 0))
                            } else if ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentStatusId == 3{
                                Helper.openGoogleMap(longitude: Double(ApprovedShipmentVM.publishedapprovedShipmentModel?.fromLang ?? 0), latitude: Double(ApprovedShipmentVM.publishedapprovedShipmentModel?.fromLat ?? 0))
                            }else{
                                Helper.openGoogleMap(longitude: Double(ApprovedShipmentVM.publishedapprovedShipmentModel?.toLang ?? 0), latitude: Double(ApprovedShipmentVM.publishedapprovedShipmentModel?.toLat ?? 0))
                            }
//                            ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentStatusId == 2 ? Helper.openGoogleMap(longitude: ApprovedShipmentVM.publishedapprovedShipmentModel?.fromLang, latitude: ApprovedShipmentVM.publishedapprovedShipmentModel?.fromLat)  : ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentStatusId == 3 ? Helper.openGoogleMap(longitude: ApprovedShipmentVM.publishedapprovedShipmentModel?.fromLang, latitude: ApprovedShipmentVM.publishedapprovedShipmentModel?.fromLat) : Helper.openGoogleMap(longitude: ApprovedShipmentVM.publishedapprovedShipmentModel?.toLang, latitude: ApprovedShipmentVM.publishedapprovedShipmentModel?.toLat)
                        }) {
                            ZStack{
                                Color(#colorLiteral(red: 0.809019506, green: 0.7819704413, blue: 0.8611868024, alpha: 1)).frame(width : 100 , height: 40)
                                Text("Location").foregroundColor(Color(#colorLiteral(red: 0.2833708227, green: 0.149017632, blue: 0.4966977239, alpha: 1)))
                                    .font(Font.camelfonts.Reg16)

                            }.cornerRadius(8)
                        }
                    }
                    .padding()
                    .frame(height: 80 )
                    Image( ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentStatusId == 2 ? "ic_status1":ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentStatusId == 3 ? "ic_status2":"ic_status3")
                        .frame(height: 40 )
                    HStack {
                        Text(ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentStatusName ?? "Waiting_to_start")
                            .font(Font.camelfonts.Reg16)
                            .foregroundColor(Color.gray)
                            .frame(height: 20)
                        Spacer()
                    }.padding()
                }
            }
            ZStack{
                Image("ic_ship_orange" )
                    .resizable()
                    .padding(.horizontal,-20)
                Button(action: {
                    ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentStatusId == 2 ?
                    ApprovedShipmentVM.ApprovedAction(operation: .start) :ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentStatusId == 3 ?
                    ApprovedShipmentVM.ApprovedAction(operation: .Upload):ApprovedShipmentVM.ApprovedAction(operation: .finish)
                    
                }, label: {
                    Text(ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentStatusId == 2 ? "Start_Shipment".localized(language):ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentStatusId == 3 ? "Uploaded".localized(language):"Dropped_&_Finished".localized(language))
                        .foregroundColor(Color.white)
                        .font(Font.camelfonts.Reg16)
                })
                

            }
            .frame(height: 50)
        }
        .frame(height: 280)
        .cornerRadius(10)
        .padding()
//        .shadow(color: Color("Second_Color").opacity(0.36), radius: 0 , x: 0, y: 4)
    }
}

struct ShipView_Previews: PreviewProvider {
    static var previews: some View {
        ShipView().environmentObject(ApprovedShipmentViewModel())
    }
}
