//
//  ShipView.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 7/23/22.
//

import SwiftUI

struct ShipView: View {
    var body: some View {
        VStack(spacing: 0){
            ZStack{
                Image("ic_ship_purple").resizable()
                HStack(spacing: 10){
                    Text("Shipment").foregroundColor(Color.white)
                    Text("#3245534")
                        .foregroundColor(Color.white)
                    Spacer()
                }
                .padding(.leading)
            }
            .frame(height: 50)
            ZStack{
                Color(#colorLiteral(red: 0.9413323998, green: 0.9409359097, blue: 0.9541043639, alpha: 1))
                VStack {
                    HStack(){
                        VStack(alignment: .leading){
                            Text("Delivery")
                            HStack{
                                Text("Sun. 12/5/2022")
                                Text(".")
                                Text("1:30 AM")
                            }
                        }
                        Spacer()
                        Button(action: {}) {
                            ZStack{
                                Color(#colorLiteral(red: 0.809019506, green: 0.7819704413, blue: 0.8611868024, alpha: 1)).frame(width : 100 , height: 40)
                                Text("Location").foregroundColor(Color(#colorLiteral(red: 0.2833708227, green: 0.149017632, blue: 0.4966977239, alpha: 1)))
                            }.cornerRadius(8)
                        }
                    }
                    .padding()
                    .frame(height: 80 )
                    Image("ic_status1")
                        .frame(height: 40 )
                    HStack {
                        Text("On the Way to Upload")
                            .foregroundColor(Color.gray)
                            .frame(height: 20)
                        Spacer()
                    }.padding()
                }
            }
            ZStack{
                Image("ic_ship_orange").resizable()
                Text("Uploaded").foregroundColor(Color.white)
            }
            .frame(height: 50)
        }
        .frame(height: 280)
        .cornerRadius(10)
        .padding()
//        .shadow(color: Color("Second_Color").opacity(0.36), radius: 0 , x: 0, y: 4)
    }
}

struct ShipView_Previews: PreviewProvider {
    static var previews: some View {
        ShipView()
    }
}
