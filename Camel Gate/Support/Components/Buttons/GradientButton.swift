//
//  GradientButton.swift
//  Camel Gate
//
//  Created by wecancity on 31/07/2022.
//

import SwiftUI

struct GradientButton: View {
    var action: () -> Void
    var Title = ""
    @Binding var IsDisabled:Bool
    var body: some View {
        
        Button(action: {
            DispatchQueue.main.async{
                // Action
                action()
            }
        }, label: {
            HStack {
                Text(Title.localized(language))
                    .font( language.rawValue == "ar" ? Font.camelfonts.BoldAr14:Font.camelfonts.Bold14)
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
                ).opacity(IsDisabled ? 0.5:1)
            )
            .cornerRadius(12)
            .padding(.horizontal, 20)
            .padding(.bottom)
        })
            .disabled(IsDisabled)
    }
}

struct GradientButton_Previews: PreviewProvider {
    static var previews: some View {
        GradientButton(action: {}, IsDisabled: .constant(false))
    }
}
