//
//  SwitchLanguageButton.swift
//  Camel Gate
//
//  Created by wecancity on 07/02/2023.
//

import SwiftUI

struct SwitchLanguageButton: View {
var language = LocalizationService.shared.language
    var body: some View {
        Button(action: {
            
            language.rawValue == "en" ?
            withAnimation {
                DispatchQueue.main.async(execute: {
                    LocalizationService.shared.language = .arabic
                    Helper.setLanguage(currentLanguage: "ar")
                })
            }
            :
            withAnimation {
                DispatchQueue.main.async(execute: {
                    LocalizationService.shared.language = .english_us
                    Helper.setLanguage(currentLanguage: "en")
                })
            }
            
            
        }, label: {
            HStack(){
                Image(language.rawValue == "ar" ? "usaFlag":"saudiFlag")
                    .foregroundColor(Color("blueColor"))
                    .aspectRatio( contentMode: .fill)
                    .cornerRadius(8)
                Text(language.rawValue == "ar" ? "Engligh":"العربية")
                    .foregroundColor(.secondary)
                    .font( language.rawValue == "en" ? Font.camelfonts.SemiBoldAr14:Font.camelfonts.SemiBold14)
            }
        })
            .padding(.horizontal)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(12)
            .buttonStyle(.plain)
    }
}
