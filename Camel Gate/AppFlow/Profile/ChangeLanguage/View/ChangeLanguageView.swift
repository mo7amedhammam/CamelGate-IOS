//
//  ChangeLanguageView.swift
//  Camel Gate
//
//  Created by wecancity on 27/07/2022.
//

import SwiftUI

struct ChangeLanguageView: View {
    
    @State var currentlanguage = "en"
    
    var body: some View {
        ZStack{
            
            VStack (spacing: 15){
                
                Button(action: {
                    currentlanguage = "en"
                    LocalizationService.shared.language = .english_us
                    Helper.setLanguage(currentLanguage: "en")

                }, label: {
                    HStack{
                        Image(systemName:currentlanguage == "en" ? "circle.fill":"circle")
                        Text("English".localized(language))
                    Spacer()
                    }.padding()
                        .foregroundColor(.black.opacity(currentlanguage == "en" ? 0.7:0.3))
                })
                
                Button(action: {
                    currentlanguage = "ar"
                    LocalizationService.shared.language = .arabic
                    Helper.setLanguage(currentLanguage: "en")

                }, label: {
                    HStack{
                        Image(systemName:currentlanguage == "ar" ? "circle.fill":"circle")
                        Text("English".localized(language))
                    Spacer()
                    }.padding()
                        .foregroundColor(.black.opacity(currentlanguage == "ar" ? 0.7:0.3))
                })
             Spacer()
            }
            .padding(.top,hasNotch ? 130:120)
            
            
            TitleBar(Title: "Change_Language".localized(language), leadingButton: .backButton,trailingAction: {})
        }
        .navigationBarHidden(true)
        .onAppear(perform: {
            if Helper.getLanguage() == "en" {
                currentlanguage = "en"
            } else if Helper.getLanguage() == "ar" {
                currentlanguage = "ar"
            }
        })

    }
}

struct ChangeLanguageView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeLanguageView()
        ChangeLanguageView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
    }
}
