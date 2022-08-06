//
//  HeaderView.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 7/18/22.
//

import SwiftUI

struct HeaderView: View {
    @State var destination = AnyView(NotificationsView())
    var body: some View {
        HStack {
            AsyncImage(url: URL(string:  Constants.imagesURL + Helper.getDriverimage())) { image in
                image.resizable()
            } placeholder: {
                Image("face_vector")
            }
            .overlay(Circle().stroke(.white.opacity(0.7), lineWidth: 4))

            
            VStack(alignment: .leading ){
                HStack{
                    Text(Helper.getDriverName())
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
            Button(action: {
                destination = AnyView(NotificationsView())
            }) {
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
