//
//  WalletIcon.swift
//  Camel Gate
//
//  Created by wecancity on 21/07/2022.
//

import SwiftUI

struct WalletIcon: View {
    @EnvironmentObject var environments : camelEnvironments
    var language = LocalizationService.shared.language
    
    @StateObject var HomeWalletVM = HomeWalletViewModel()
    var body: some View {
        HStack(alignment:.top){
            Button(action: {
                //                if LoginManger.getUser()?.isDriverInCompany ?? false {
                //
                //                }else{
                environments.desiredTab = "Wallet".localized(language)
                //                    }
            }, label: {
                ZStack(alignment: .leading ){
                    Image("ic_back_wallet")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 140, height: 125)

                    VStack(spacing: 8 ){
                        Image("ic_wallet")
                        Text("Wallet1".localized(language))
                            .foregroundColor(Color.white.opacity(0.7))
                            .font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)

                        Text("\(String(format:"%.2f",Float(HomeWalletVM.PublishedHomePageWalletModel?.currentBalance ?? 0)))")
                            .foregroundColor(Color.white)
                            .font(Font.camelfonts.Reg16)

                    }
                    .padding(.leading)
                }
                .padding(.bottom,-10)
            })
                .buttonStyle(.plain)
                .disabled(LoginManger.getUser()?.isDriverInCompany ?? false)
            
            ZStack(alignment: .leading ){
                VStack(spacing: 0 ){
                    HStack{
                        Image("ic_car_track")
                        VStack(alignment: .leading ){
                            Text( "\(HomeWalletVM.PublishedHomePageWalletModel?.totalUpcomingTrips ?? 0)")
                                .foregroundColor(Color(#colorLiteral(red: 0.356864363, green: 0.3568614721, blue: 0.2826236188, alpha: 1)))
                                .font(Font.camelfonts.Bold20)
                            Text("Upcoming_Trips".localized(language))
                                .foregroundColor(Color(#colorLiteral(red: 0.356864363, green: 0.3568614721, blue: 0.2826236188, alpha: 1)))
                                .font( language.rawValue == "ar" ? Font.camelfonts.SemiBoldAr11:Font.camelfonts.SemiBold11)
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(height: 50)
                    Color(#colorLiteral(red: 0.9281044006, green: 0.9126986861, blue: 0.9479321837, alpha: 1)).frame(height: 2)
                    HStack{
                        Image("ic_money")
                        VStack(alignment: .leading ){
                            Text("\(String(format:"%.2f",Float(HomeWalletVM.PublishedHomePageWalletModel?.gainedBalance ?? 0)))")
                                .foregroundColor(Color(#colorLiteral(red: 0.356864363, green: 0.3568614721, blue: 0.2826236188, alpha: 1)))
                                .font(Font.camelfonts.Bold20)
                            Text("Gained_Money".localized(language))
                                .foregroundColor(Color(#colorLiteral(red: 0.356864363, green: 0.3568614721, blue: 0.2826236188, alpha: 1)))
                                .font(.camelRegular(of: 14))

//                                .font( language.rawValue == "ar" ? Font.camelfonts.SemiBoldAr11:Font.camelfonts.SemiBold11)
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(height: 50)
                }
            }
            .frame(height: 116)
            .background(Color.white)
            .clipped()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color("Base_Color"), lineWidth: 0.2)
            )
            .cornerRadius(12)
            .shadow(color: Color("Base_Color").opacity(0.08), radius: 3.0 , x: 0, y: 4)
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
}

struct WalletIcon_Previews: PreviewProvider {
    static var previews: some View {
        WalletIcon()
            .environmentObject(camelEnvironments())
    }
}
