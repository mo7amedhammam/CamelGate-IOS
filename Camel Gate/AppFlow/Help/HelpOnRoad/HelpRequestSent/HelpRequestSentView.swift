//
//  HelpRequestSentView.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 8/13/22.
//

import SwiftUI

struct HelpRequestSentView: View {
    var language = LocalizationService.shared.language

    @Binding var showPopUp :Bool
    var body: some View {
        VStack{
            Spacer()
            Text("Help Request Sent".localized(language))
                .font(Font.camelfonts.Bold20)
                .frame(width:UIScreen.main.bounds.width)
                .overlay(HStack{
                    Spacer()
                    Button(action: {
                        showPopUp.toggle()
                    }, label: {
                        Image(systemName: "x.circle.fill")
                            .font(.title)
                            .foregroundColor(.gray.opacity(0.6))
                    })
                }
                            .padding()
                )
            ScrollView{
                Image("help_done")
                Text("Help request had been sent to every near driver and the second they accept the request you will get notified.")
                Button(action: {
                    showPopUp.toggle()
                }) {
                    ZStack{
                        Color("Base_Color")
                        Text("Ok").foregroundColor(Color.white)
                    }.cornerRadius(10)
                    .padding()
                    .frame(height: 90)
                }
            }
        }
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

    }
}

struct HelpRequestSentView_Previews: PreviewProvider {
    static var previews: some View {
        HelpRequestSentView(showPopUp: .constant(true) )
    }
}
