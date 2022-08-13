//
//  HelpOnRoadView.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 8/8/22.
//

import SwiftUI

struct HelpOnRoadView: View {
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
                                            .font(Font.camelfonts.SemiBold16)
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
                            InputTextField(iconName: "phoneBlue",iconColor: Color("blueColor"), placeholder: "Enter_your_Phone_number".localized(language), text:.constant("01101201322"))
                            
                            //if text is fixed use $BindingVariable
                            InputTextField(iconName: "phoneBlue",iconColor: Color("blueColor"), placeholder: "Enter_your_phone_number".localized(language), text: $phoneNumber)
//                                .keyboardType(.numberPad)
////                                .overlay(
////                                    RoundedRectangle(cornerRadius: 8)
//////                                        .stroke(.red, lineWidth:SignInVM.validations == .PhoneNumber ? 1:0).padding(.horizontal)
////                                )
//                            InputTextField(iconName: "phoneBlue",iconColor: Color("blueColor"), placeholder: "Enter_your_phone_number".localized(language), text: "aaa")
//                                .padding(.horizontal)
//                                .keyboardType(.numberPad)
////                                .overlay(
////                                    RoundedRectangle(cornerRadius: 8)
//////                                        .stroke(.red, lineWidth:SignInVM.validations == .PhoneNumber ? 1:0).padding(.horizontal)
////                                )
                        }
                        .padding(.horizontal)
                        .font(Font.camelfonts.Reg16)
                        .ignoresSafeArea(.keyboard)
                    }
                }.padding(.top , 110)
                TitleBar(Title: "Help On Road" , navBarHidden: true, leadingButton: .backButton , trailingAction: {
                })
            }.edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct HelpOnRoadView_Previews: PreviewProvider {
    static var previews: some View {
        HelpOnRoadView()
    }
}
