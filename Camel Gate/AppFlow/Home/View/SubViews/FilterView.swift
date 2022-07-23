//
//  FilterView.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 7/23/22.
//

import SwiftUI

struct FilterView: View {
    var delete : Bool
    let filterTitle : String
    var D : (()->())?
    var body: some View {
        if (delete) {
            ZStack{
                Color(#colorLiteral(red: 0.9521436095, green: 0.9569442868, blue: 0.9612503648, alpha: 1))
                HStack{
                    Text(filterTitle).foregroundColor(Color.gray)
                    Spacer()
                    Button(action: {
                        D?()
                    }) {
                        Image("ic_x")
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                }.padding()
            }
            .frame(height: 40)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray, lineWidth: 1))
            .cornerRadius(20)
        }
    }
}

