//
//  HelpOnRoadView.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 8/8/22.
//

import SwiftUI

struct HelpOnRoadView: View {
    var language = LocalizationService.shared.language

    @State var helpBtns = ["Request Form","Help Offers"]
    @State var selected = "Request Form"
    
    @State var phoneNumber = "011111222222"
    var body: some View {
        VStack{
            ZStack{
                ScrollView{
                    VStack{
                        HStack(spacing: 20.0){
                            ForEach(helpBtns,id:\.self){ Category in
                                Button(action: {
                                    withAnimation{
                                        self.selected = Category
                                    }
                                }, label: {
                                    HStack(alignment: .center){
                                        Text(Category )
                            .font( language.rawValue == "ar" ? Font.camelfonts.SemiBoldAr16:Font.camelfonts.SemiBold16)
                                            .foregroundColor(self.selected == Category ? Color("Base_Color") : Color("lightGray"))
                                    }
                                    .padding(.horizontal, 20.0)
                                    .frame(height: 45)
                                    .clipShape(Rectangle())
                                })
                                    .background( Color(self.selected == Category ? "tabText" : "lightGray").opacity(self.selected == Category  ? 1 : 0.3)
                                                    .cornerRadius(8))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color("Base_Color"), lineWidth:self.selected == Category ? 1:0))
                            }}
                        Image("ic_help").padding()
                        HStack {
                            Text("Your Contact")
                                .font(Font.camelfonts.SemiBold14)
                            Spacer()
                        }.padding()
                        Group {
                            //if text is fixed use .constant(value)
                            InputTextField(iconName: "phoneBlue",iconColor: Color("Second_Color"), placeholder: "Enter_your_Phone_number".localized(language), text:.constant("01101201322"))
                                .keyboardType(.numberPad)

                            //if text is fixed use $BindingVariable
                            InputTextField(iconName: "phoneBlue",iconColor: Color("Second_Color"), placeholder: "Additional_Enter_your_phone_number".localized(language), text: $phoneNumber)
                                .keyboardType(.numberPad)
                        }
                        .padding(.horizontal)
.font( language.rawValue == "ar" ? Font.camelfonts.RegAr16:Font.camelfonts.Reg16)
                        .ignoresSafeArea(.keyboard)

                        Color(#colorLiteral(red: 0.3571086526, green: 0.2268399, blue: 0.5710855126, alpha: 0.09))
                            .frame(height: 1)
                            .padding(.top , 20)

                        HStack {
                            Text("Your Location")
                                .font(Font.camelfonts.SemiBold14)
                            Spacer()
                        }.padding()

                        ZStack{
                            Color(#colorLiteral(red: 0.3571086526, green: 0.2268399, blue: 0.5710855126, alpha: 0.05))
                            HStack{
                                Image("ic_pin_orange")
                                VStack(alignment : .leading){
                                    Text("Location")
                                        .foregroundColor(Color.gray)
                                                                                       .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)

                                    Text("25 ehsan st., Aggamy, Alexandria")
                                        .foregroundColor(Color.black)
                        .font( language.rawValue == "ar" ? Font.camelfonts.SemiBoldAr16:Font.camelfonts.SemiBold16)
                                }
                                Spacer()
                                Image("ic_detect_location")
                            }.padding()
                        }
                        .frame(height: 80)
                        .cornerRadius(10)
                        .padding()

                        Color(#colorLiteral(red: 0.3571086526, green: 0.2268399, blue: 0.5710855126, alpha: 0.09))
                            .frame(height: 1)
                            .padding(.top , 20)

                        HStack {
                            Text("Leave Message")
                                .font(Font.camelfonts.SemiBold14)
                            Spacer()
                        }.padding()

                        ZStack{

                        }
                        .frame(height: 100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray , lineWidth: 1))
                        .cornerRadius(10)
                        .padding()
                    }
                }.padding(.top , 110)
                TitleBar(Title: "Help On Road" , navBarHidden: true, leadingButton: .backButton , trailingAction: {
                })
            }.edgesIgnoringSafeArea(.bottom)
        }
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

    }
}

struct HelpOnRoadView_Previews: PreviewProvider {
    static var previews: some View {
        HelpOnRoadView()
    }
}

struct HelpOfferCell: View {
    var body: some View {
        ZStack{
            Color(#colorLiteral(red: 0.9725491405, green: 0.9725490212, blue: 0.9725491405, alpha: 1))
            HStack{
                Image("face_vector")
                VStack(alignment: .leading , spacing: 6){
                    Text("Tawfiq").font(Font.camelfonts.SemiBold16)
                    Text("2.5 KM . Open Truck").font(Font.camelfonts.SemiBold14)
                        .foregroundColor(Color.gray)
                }
                Spacer()
                ZStack{
                    Color(#colorLiteral(red: 0.2599548995, green: 0.8122869134, blue: 0.005582589656, alpha: 1))
                    Image("phoneBlue")
                }.frame(width: 50, height: 50).cornerRadius(10)
            }
            .padding()
        }.overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray , lineWidth: 1))
            .cornerRadius(10)
            .padding()
            .frame(height: 120)
    }
}
