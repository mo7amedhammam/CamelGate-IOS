//
//  HeaderView.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 7/18/22.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Image("face_vector")
            VStack(alignment: .leading ){
                HStack{
                    Text("Tawfiq Sweedy")
                        .font(Font.camelfonts.Bold18)
                        .foregroundColor(Color.white)
                    HStack{
                        Text("")
                        Image("ic_star")
                        Text("4.5  ")
                            .font(Font.camelfonts.Reg14)
                            .foregroundColor(Color.white)
                    }
                    .padding(3.0)
                    .background(Color.white.opacity(0.35))
                    .cornerRadius(8)
                }
                HStack{
                    Image("ic_location")
                    Text("2nd department, October, Giza")
                        .font(Font.camelfonts.Reg14)
                        .foregroundColor(Color.white)
                }
            }
            Spacer()
            Button(action: {}) {
                Image("ic_big_notification")
            }
        }
        .padding()
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
