//
//  SignUpView.swift
//  Camel Gate
//
//  Created by wecancity on 31/07/2022.
//

import SwiftUI

struct SignUpView: View {
    var body: some View {
        ZStack{
         
            VStack{
                Image("signupheaderpng")
                    .resizable()
//                    .frame(width:500)
                
                    .padding(.top,-50)
                    
                    .frame(height:320)
                
                ScrollView{
                    Image("LOGO")
                        .padding(.horizontal,90)
                    
                    Group{
                        
                        InputTextField(imagename: "Phone", placeholder: "Enter_your_phone_number".localized(language), text: .constant(""))

                        SecureInputTextField("Enter_your_password".localized(language), text: .constant(""), iconName: "")
                        SecureInputTextField("Confirm_your_password".localized(language), text: .constant(""), iconName: "")

                    }
                    .font(Font.camelfonts.Reg16)
                    .ignoresSafeArea(.keyboard)
                    
                    
                }
                
                    
                Spacer()
            }
//            .padding(.horizontal,-30)
            BottomSheetView(IsPresented: .constant(true), withcapsule: false, bluryBackground: false, content: {
                GradientButton(action: {
                }, Title: "Create_account".localized(language))
                
                HStack {
                    Text("have_an_Account? ".localized(language)).foregroundColor(.secondary)
                    
                    Button("Sign_In".localized(language)) {
  
                    }
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(Color("blueColor"))
                    
                }.padding(.top,-30)
                    .padding(.bottom)
                
            })
            
        }
        .overlay(content: {
            VStack{
                
                HStack{
                    BackButtonView()
                    Spacer()
                    Text("Sign_Up".localized(language))
                        .foregroundColor(.white)
                        .font(Font.camelfonts.Med20)
                       Spacer()
                    Spacer().frame(width:50)
                }
                .padding()
                .padding(.top,10)
                Spacer()
            }
        })
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
