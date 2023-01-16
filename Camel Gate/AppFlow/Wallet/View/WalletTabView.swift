//
//  WalletView.swift
//  Camel Gate
//
//  Created by wecancity on 21/07/2022.
//

import SwiftUI
//import SwiftUICharts

struct WalletView: View {
    var language = LocalizationService.shared.language
    @State var WalletCategory = ["Gained","Withdrawn"]
    @State var selected = "Gained"
    @StateObject var WalletVM = WalletViewModel()
    @EnvironmentObject var environments : camelEnvironments
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
                                        Text("\(String(format: "%.2f", Float(WalletVM.publishedUserWalletModel.currentBalance ?? 0)))")
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
                                            Text(Category.localized(language) )
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
                                
                                Text("\(selected == "Gained" ? "\(String(format:"%.2f",Float(WalletVM.publishedUserWalletModel.gainedBalance ?? 0)))" : "\(String(format:"%.2f",Float(WalletVM.publishedUserWalletModel.currentBalance ?? 0)))" )" )
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
                                    Text("No_Payment_had_been_done_yet".localized(language))
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
            TitleBar(Title: "Wallet".localized(language), navBarHidden: true, trailingButton: TopButtons.none ,trailingAction: {
            })
        }
        .overlay(
            ZStack{
            if WalletVM.isAlert{
                CustomAlert(presentAlert: $WalletVM.isAlert,alertType: .error(title: "", message: WalletVM.message, lefttext: "", righttext: "OK".localized(language)),rightButtonAction: {
                    if WalletVM.activeAlert == .unauthorized{
                        Helper.logout()
                        LoginManger.removeUser()
                        Helper.IsLoggedIn(value: false)
//                        destination = AnyView(SignInView())
//                        active = true
                    }
                    WalletVM.isAlert = false
                    environments.isError = false
                })
                }
            }.ignoresSafeArea()
                .edgesIgnoringSafeArea(.all)
                .onChange(of: WalletVM.isAlert, perform: {newval in
                    DispatchQueue.main.async {
                        if newval == true{
                    environments.isError = true
                    }
                    }
                })
                .onAppear(perform: {
                    if environments.isError == false && WalletVM.isAlert == true{
                        environments.isError = true
                    }
                })
        )
        .overlay(content: {
            // showing loading indicator
            AnimatingGif(isPresented: $WalletVM.isLoading)
        })
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
        
        
        // Alert with no internet connection
//            .alert(isPresented: $WalletVM.isAlert, content: {
//                Alert(title: Text(WalletVM.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
//                    if WalletVM.activeAlert == .unauthorized{
//                        Helper.logout()
//                        LoginManger.removeUser()
//                        Helper.IsLoggedIn(value: false)
////                        destination = AnyView(SignInView())
////                        active = true
//                    }
//                    WalletVM.isAlert = false
//                }))
//            })
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            WalletView( SelectedTab: .constant("Wallet"))
        }
    }
}


public extension String {
    /// Removes any appearance of any characters in the character set.
    /// - Parameter characterSet: Characters to be removed.
    /// - Returns: Removed characters version of the string
    func clippingCharacters(in characterSet: CharacterSet) -> String {
        components(separatedBy: characterSet).joined()
    }
}
public extension String {
    private static let formatter = NumberFormatter()

    /// Converts any digit in any language represented in the string and returns the converted string.
    /// - Parameter locale: Destination locale.
    /// - Returns: Converted string.
    func convertedDigitsToLocale(_ locale: Locale = .current) -> String {
        let digits = Set(clippingCharacters(in: CharacterSet.decimalDigits.inverted))
        guard !digits.isEmpty else { return self }

        Self.formatter.locale = locale
        /// Find all digits and build a map table for them.
        let maps: [(original: String, converted: String)] = digits.map {
            let original = String($0)
            // NumberFormatter can always create a number form decimalDigits characterSet. No need for check.
            let digit = Self.formatter.number(from: original)!

            // A digit that created from a string can always convert back to string. No need for check.
            let localized = Self.formatter.string(from: digit)!
            return (original, localized)
        }

        return maps.reduce(self) { converted, map in
            converted.replacingOccurrences(of: map.original, with: map.converted)
        }
    }

    /// Converts any digit in any language represented in the string and returns the converted string.
    /// - Parameter identifier: Destination locale identifier.
    /// - Returns: Converted string.
    func convertedDigitsToLocale(identifier: String = Locale.current.identifier) -> String {
        convertedDigitsToLocale(Locale(identifier: identifier))
    }
}
