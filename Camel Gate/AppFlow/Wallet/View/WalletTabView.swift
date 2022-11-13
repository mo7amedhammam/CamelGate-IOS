//
//  WalletView.swift
//  Camel Gate
//
//  Created by wecancity on 21/07/2022.
//

import SwiftUI
import SwiftUICharts

struct WalletView: View {
    var language = LocalizationService.shared.language
    @State var WalletCategory = ["Gained","Withdrawn"]
    @State var selected = "Gained"
    @StateObject var WalletVM = WalletViewModel()
    @EnvironmentObject var environments : imageViewModel
    @Binding var SelectedTab : String
    var body: some View {
        ZStack{
            VStack{
                Spacer(minLength: hasNotch ? 90:70 )
                if LoginManger.getUser()?.isDriverInCompany==true{
                    VStack{
                        Spacer()
                        Text("you_Can't_See_Wallet".localized(language))
                        Spacer()
                    }
                }else{
//                    ScrollView {
                        VStack{
                            ZStack{
                                Color(#colorLiteral(red: 0.943169415, green: 0.9325224757, blue: 0.9590196013, alpha: 1))
                                Image("vector_back_wallet")
                                    .resizable()
                                VStack{
                                    HStack(alignment:.bottom){
                                        Text("\(WalletVM.publishedUserWalletModel.currentBalance ?? 0)")
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("Base_Color"))
                                            .font( language.rawValue == "ar" ? Font.camelfonts.SemiBoldAr24:Font.camelfonts.SemiBold24)

                                        
                                        Text("SAR".localized(language))
                                            .foregroundColor(Color.gray)
                                            .font( language.rawValue == "ar" ? Font.camelfonts.SemiBoldAr14:Font.camelfonts.SemiBold14)

                                    }
                                    Text("Current_Balance".localized(language))
                                        .foregroundColor(Color.gray)
                                        .font( language.rawValue == "ar" ? Font.camelfonts.Reg12:Font.camelfonts.Reg12)

                                        .padding(.top,1)
                                }
                            }
                            .frame(height: 180).cornerRadius(12)
                            
                            HStack(spacing: 0.0){
                                ForEach(WalletCategory,id:\.self){ Category in
                                    Button(action: {
                                        withAnimation{
                                            self.selected = Category
                                            if selected == "Gained"{
                                                WalletVM.GetWallet(type: .Gained)
                                            }else if selected == "Withdrawn"{
                                                WalletVM.GetWallet(type: .Withdrawn)
                                            }
                                        }
                                        print("----\(WalletVM.publishedUserWalletModel.gainedBalance ?? 0)")
                                    }, label: {
                                        HStack(alignment: .center){
                                            Text(Category )
                                                .font( language.rawValue == "ar" ? Font.camelfonts.SemiBoldAr16:Font.camelfonts.SemiBold16)
                                                .foregroundColor(self.selected == Category ? Color.white : Color("lightGray"))
                                        }
                                        .frame(width: 110, height:selected==Category ? 40:32)
                                        .clipShape(Rectangle())
                                    })
                                        .background( Color(self.selected == Category ? "Base_Color" : "lightGray")
                                        .opacity(self.selected == Category  ? 1 : 0.3)
                                        .cornerRadius(8))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(.blue, lineWidth:self.selected == Category ? 1:0))
                                        }}
                                        .padding(.top, -60)
                            Color(#colorLiteral(red: 0.3571086526, green: 0.2268399, blue: 0.5710855126, alpha: 0.09)).frame(height: 1)
                            HStack {
                                Text("Payment_Details".localized(language))
                                    .font( language.rawValue == "ar" ? Font.camelfonts.BoldAr14:Font.camelfonts.Bold14)
                                    .foregroundColor(Color.gray)
                                Spacer()
                                Text("Total_:".localized(language))
                                    .font( language.rawValue == "ar" ? Font.camelfonts.BoldAr14:Font.camelfonts.Bold14)
                                    .foregroundColor(Color.gray)
                                
                               Text("\(WalletVM.publishedUserWalletModel.gainedBalance ?? 0)")
                                    .font( language.rawValue == "ar" ? Font.camelfonts.BoldAr14:Font.camelfonts.Bold14)
                                    .foregroundColor(Color.gray)
                            }
                            .frame(height: 30)
                            .padding(.horizontal , 20.0)
                            Color(#colorLiteral(red: 0.3571086526, green: 0.2268399, blue: 0.5710855126, alpha: 0.09)).frame(height: 1)

                            
                            if WalletVM.publishedUserWalletModel.shipmentPayments == [] || WalletVM.publishedUserWalletModel.shipmentPayments == nil{
                                
                                VStack(spacing:15){
                                    Spacer()
                                    Image("nopayment")
                                    Text("No_Payment_had_been_done_yet!".localized(language))
                                        .font( language.rawValue == "ar" ? Font.camelfonts.SemiBoldAr16:Font.camelfonts.SemiBold16)
                                        .foregroundColor(.black).opacity(0.8)

                                    Text("Get_accepted_at_some_shipments\nand_gain_some_money...".localized(language))
                                        .multilineTextAlignment(.center)
                                        .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)
                                        .foregroundColor(.gray)

                                    Button(action: {
                                        withAnimation{
                                         SelectedTab = "Shipments".localized(language)
                                        }
                                    }, label: {
                                        HStack {
                                            Text("Check_Shipments".localized(language))
                                                .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)

                                        }
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .frame(height:22)
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(
                                            LinearGradient(
                                                gradient: .init(colors: [Color("linearstart"), Color("linearend")]),
                                                startPoint: .trailing,
                                                endPoint: .leading
                                            )
                                        )
                                        .cornerRadius(12)
                                        .padding(.horizontal, 100)
                                    })
                                    
                                    Spacer()

                                }
                                .padding(.bottom,50)
                                
                            }else{
                            ScrollView(.vertical , showsIndicators : false){
//                                VStack(spacing:0){
                                    ForEach(WalletVM.publishedUserWalletModel.shipmentPayments ?? [],id:\.self) { walletitem in
                                        WalletViewCell(Category: $selected,walletitem:walletitem)
                                            .environmentObject(environments)
                                            .padding(.horizontal,10)
                                    }
                                }
                            }
                        }
//                    }
                }
            }
            TitleBar(Title: "Wallet", navBarHidden: true, trailingButton: TopButtons.none ,trailingAction: {
            })
        }
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            WalletView( SelectedTab: .constant("Wallet"))
        }
    }
}


