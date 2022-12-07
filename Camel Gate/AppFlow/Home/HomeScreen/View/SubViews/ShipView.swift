//
//  ShipView.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 7/23/22.
//

import SwiftUI

struct ShipView: View {
    var language = LocalizationService.shared.language

    @EnvironmentObject var ApprovedShipmentVM:ApprovedShipmentViewModel
    @EnvironmentObject var environments : camelEnvironments
    @State var confirmAlert = false
    @State var confirmMessage = ""

//    @Binding var ShowMapRedirector:Bool
//    @Binding var longitude:Double
//    @Binding var latitude:Double
    var body: some View {
        VStack(spacing: 0){
            ZStack{
                Image("ic_ship_purple").resizable()
                HStack(spacing: 10){
                    Text("Shipment".localized(language)).foregroundColor(Color.white)
                    Text("#\(ApprovedShipmentVM.publishedapprovedShipmentModel?.code ?? "")")
                        .foregroundColor(Color.white)
                    Spacer()
                }
.font( language.rawValue == "ar" ? Font.camelfonts.SemiBoldAr16:Font.camelfonts.SemiBold16)
                .padding(.leading)
            }
            .frame(height: 50)
            ZStack{
                Color(#colorLiteral(red: 0.9413323998, green: 0.9409359097, blue: 0.9541043639, alpha: 1))
                VStack {
                    HStack(){
                        VStack(alignment: .leading){
                            Text("Delivery".localized(language))
                            HStack{
                                Text(
                                    ConvertStringDate(inp:ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentDateTo ?? "2022-08-17T00:00:00",FormatFrom:"yyyy-MM-dd'T'HH:mm:ss",FormatTo:"E. dd/MM/yyyy . h:m aa")
                                )
                            }
                        }
.font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
                        Spacer()
                        Button(action: {
                            if ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentStatusId == 2{
                                environments.Destinationlongitude = Double(ApprovedShipmentVM.publishedapprovedShipmentModel?.fromLang ?? 0)
                                environments.Destinationlatitude = Double(ApprovedShipmentVM.publishedapprovedShipmentModel?.fromLat ?? 0)
                            } else if ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentStatusId == 3{
                                environments.Destinationlongitude = Double(ApprovedShipmentVM.publishedapprovedShipmentModel?.toLang ?? 0)
                                environments.Destinationlatitude = Double(ApprovedShipmentVM.publishedapprovedShipmentModel?.toLat ?? 0)
                            }else{
                                environments.Destinationlongitude = Double(ApprovedShipmentVM.publishedapprovedShipmentModel?.toLang ?? 0)
                                environments.Destinationlatitude = Double(ApprovedShipmentVM.publishedapprovedShipmentModel?.toLat ?? 0)
                            }
                            environments.ShowMapRedirector = true

                        }) {
                            ZStack{
                                Color(#colorLiteral(red: 0.809019506, green: 0.7819704413, blue: 0.8611868024, alpha: 1)).frame(width : 100 , height: 40)
                                Text("Location".localized(language)).foregroundColor(Color(#colorLiteral(red: 0.2833708227, green: 0.149017632, blue: 0.4966977239, alpha: 1)))
            .font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)

                            }.cornerRadius(8)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal)
                    .padding(.top)

                    //                    .frame(height: 60 )
                    Image( ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentStatusId == 2 ? "ic_status1":ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentStatusId == 3 ? "ic_status2":"ic_status3")
                        .frame(height: 40 )
                    HStack {
                        Text(ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentStatusName ?? "Waiting_to_start")
    .font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
                            .foregroundColor(Color.gray)
                            .frame(height: 20)
                        Spacer()
                    }
                    .padding(.horizontal)
                }
            }
            ZStack{
                Image("ic_ship_orange" )
                    .resizable()
                    .padding(.horizontal,-4)
                    .padding(.bottom,-5)

                Button(action: {
                        showConfirmAlert()
                }, label: {
                    HStack {
                        Text(ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentStatusId == 2 ? "Start_Shipment".localized(language):ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentStatusId == 3 ? "Uploaded".localized(language):"Dropped_&_Finished".localized(language))
                            .foregroundColor(Color.white)
                        .font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
                    }
                })                
                    .alert("\(confirmMessage)".localized(language), isPresented: $confirmAlert, actions: {
                        Button("yes_".localized(language), action: {
                                ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentStatusId == 2 ?
                                ApprovedShipmentVM.ApprovedAction(operation: .start) :ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentStatusId == 3 ? ApprovedShipmentVM.ApprovedAction(operation: .Upload):ApprovedShipmentVM.ApprovedAction(operation: .finish)
                        })
                        Button("Not_now".localized(language), action: {
                            confirmAlert = false
                            confirmMessage = ""
                        })
                    })
                
            }
            .frame(height: 50)
        }
//        .frame(height: 280)
        .cornerRadius(10)
//        .padding()
    }
    
    func showConfirmAlert() {
        
        switch   ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentStatusId {
        case 2:
            confirmMessage="are_you_sure_To_Start_now?"
        case 3:
            confirmMessage="are_you_sure_To_Upload_now?"
        case 4:
            confirmMessage="Did_you_realy_Finish_Shipment?"
        default:
            return
        }
//        DispatchQueue.main.async(execute: {
        confirmAlert = true
//        })
        //        ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentStatusId == 2 ? confirmMessage="are_you_sure_To_Start_now?":ApprovedShipmentVM.publishedapprovedShipmentModel?.shipmentStatusId == 3 ? confirmMessage = "are_you_sure_To_Upload_now?":confirmMessage = "Did_you_realy_Finish_Shipment?"
    }
    
}

struct ShipView_Previews: PreviewProvider {
    static var previews: some View {
        ShipView()
            .environmentObject(ApprovedShipmentViewModel())
            .environmentObject(camelEnvironments())
    }
}
