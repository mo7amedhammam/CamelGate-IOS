//
//  ChatHeader.swift
//  Camel Gate
//
//  Created by wecancity on 28/07/2022.
//

import SwiftUI

struct ChatHeader: View {
    var body: some View {
        VStack{
            ZStack{
                Image("chat-header")
                    .resizable()
                    .frame(height:hasNotch ? 260:240)
                    .padding(.leading,-1)
                    .shadow(color: .black.opacity(0.5), radius: 7)
                
                VStack {
                    HStack{
                        Spacer()
                        Image("chatcamellogo")
                        Spacer()
                    }
                    .frame(height:80)
                    .overlay(content: {
                        HStack{
                            XButton()
                            Spacer()
                        }.padding(.horizontal,25)
                })
                    HStack{
                        Text("Hello 👋 ,".localized(language))
                        Text("Ahmed")
                }
                    Text("How could we help you?")
                                                                       .font( language.rawValue == "ar" ? Font.camelfonts.RegAr14:Font.camelfonts.Reg14)

                        .padding(.top,-8)
                }
                .foregroundColor(.white)
.font( language.rawValue == "ar" ? Font.camelfonts.SemiBoldAr22:Font.camelfonts.SemiBold22)
                .offset(y:hasNotch ? -20:-30)
            }
            
            Spacer()
        }.ignoresSafeArea()
    }
}

struct ChatHeader_Previews: PreviewProvider {
    static var previews: some View {
        ChatHeader()
        ChatHeader()
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
    }
}
