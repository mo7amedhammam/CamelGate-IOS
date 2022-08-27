//
//  FilterView.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 7/23/22.
//

import SwiftUI

struct FilterView: View {
    var language = LocalizationService.shared.language
    var delete : Bool
    let filterTitle : String
    var D : (()->())?
    var body: some View {
        if (delete) {
            ZStack{
                HStack{
                    Text(filterTitle)
                       .font( language.rawValue == "ar" ? Font.camelfonts.LightAr16:Font.camelfonts.Light16)
                    Spacer()
                    Button(action: {
                        D?()
                    }) {
                        Image("ic_x")
                            .renderingMode(.template)
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                    }
                }.padding()
                    .foregroundColor(Color("OrangColor"))
            }
            .background(
                Color("OrangColor").opacity(0.06)
            )
            .frame(height: 35)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color("OrangColor"), lineWidth: 1))
            .cornerRadius(20)
        }
    }
}


struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(delete: true, filterTitle: "Cairo", D: {})
        
    }
}
