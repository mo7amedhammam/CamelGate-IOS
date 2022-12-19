//
//  WalletViewCell.swift
//  Camel Gate
//
//  Created by wecancity on 20/10/2022.
//

import SwiftUI
struct WalletViewCell : View {
    var language = LocalizationService.shared.language

    
    @Binding var Category : String
    var walletitem:ShipmentPayment? = ShipmentPayment.init()
    @State var active = false
    @State var destination = AnyView(ChatsListView())
    @EnvironmentObject var environments : camelEnvironments
    
    @State var day = ""
    @State var month = ""
    @State var year = ""
    
    var body: some View {
        VStack{
            Color( #colorLiteral(red: 0.3571086526, green: 0.2268399, blue: 0.5710855126, alpha: 0.09))
                .frame(height: 1)
            HStack(spacing:10){
                ZStack{
                    Category == "Gained" ? Color( #colorLiteral(red: 0.2599548995, green: 0.8122869134, blue: 0.005582589656, alpha: 1)):Color("withdrawn")
                    VStack() {
                        Text("\( ConvertStringDate(inp: walletitem?.date ?? "", FormatFrom: "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS", FormatTo: "dd MMM") )")

                        Text("\( ConvertStringDate(inp: walletitem?.date ?? "", FormatFrom: "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS", FormatTo: "yyyy") )")
                    }
                    .font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
                    .foregroundColor(Color.white)
                }.frame(width: 80, height: 80).cornerRadius(10)
                VStack(alignment : .leading ){
                    HStack{
                        HStack(spacing:2){
                            Text("\(String(format:"%.2f",Float(walletitem?.gainedValue ?? 0)))")
                                .font( language.rawValue == "ar" ? Font.camelfonts.BoldAr14:Font.camelfonts.Bold14)
                            
                            Text("SAR".localized(language))
                                .font( language.rawValue == "ar" ? Font.camelfonts.RegAr11:Font.camelfonts.Reg11)
                        }
                        Text("Gained".localized(language))
                            .foregroundColor(Category == "Gained" ? Color( #colorLiteral(red: 0.2599548995, green: 0.8122869134, blue: 0.005582589656, alpha: 1)) : Color("withdrawn"))
                            .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)
                        
                    }
                    Spacer()
                    HStack{
                        HStack(spacing:2){
                            Text("\(String(format:"%.2f",Float(walletitem?.offerValue ?? 0)))")
                                .font( language.rawValue == "ar" ? Font.camelfonts.BoldAr14:Font.camelfonts.Bold14)
                            
                            Text("SAR".localized(language))
                                .font( language.rawValue == "ar" ? Font.camelfonts.RegAr11:Font.camelfonts.Reg11)
                        }
                        Text("Offered".localized(language))
                            .foregroundColor(Category == "Gained" ? Color( #colorLiteral(red: 0.2599548995, green: 0.8122869134, blue: 0.005582589656, alpha: 1)) : Color("withdrawn"))
                            .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)
                    }                    
                }
                .padding(.vertical)
                Spacer()
                //                            if Category == "Gained"{
                
                VStack(alignment:.trailing) {
                    Spacer()
                    Button(action: {
                        active = true
                        destination = AnyView (DetailsView(shipmentId: walletitem?.id ?? 0, CommingFromWallet: true).environmentObject(environments))
                        //                                                    .environmentObject(environments))
                        
                    }) {
                        Text("View_Shipment".localized(language))
                            .foregroundColor(Category == "Gained" ? Color( #colorLiteral(red: 0.2599548995, green: 0.8122869134, blue: 0.005582589656, alpha: 1)) : Color("withdrawn")).cornerRadius(10)
                            .font( language.rawValue == "ar" ? Font.camelfonts.RegAr12:Font.camelfonts.Reg12)
                            .padding(.horizontal,10)
                            .frame(height:40)
                            .background(
                                Category == "Gained" ?   Color(#colorLiteral(red: 0.92371732, green: 0.9792584777, blue: 0.9036960006, alpha: 1)):Color("withdrawn").opacity(0.2)
                            )
                            .cornerRadius(8)
                    }
                }
                .padding(.vertical)
                //                            }
                
            }
            Color(#colorLiteral(red: 0.3571086526, green: 0.2268399, blue: 0.5710855126, alpha: 0.09))
                .frame(height: 1)
        }
        NavigationLink(destination: destination,isActive:$active , label: {
        })
        
    }
}
struct WalletViewCell_Previews: PreviewProvider {
    static var previews: some View {
        WalletViewCell(Category: .constant("Gained"), walletitem: ShipmentPayment.init())
            .previewLayout(.sizeThatFits)
            .frame( height: 120)
    }
}
