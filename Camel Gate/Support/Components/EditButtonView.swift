//
//  EditButtonView.swift
//  Camel Gate
//
//  Created by wecancity on 21/07/2022.
//

import SwiftUI

struct EditButtonView: View {
    var action: () -> Void
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Image("edit")
                .renderingMode(.original)
                .foregroundColor(.white)
                .padding()
                .font(.system(size: 22, weight: .bold))
                .background(
                    Rectangle()
                        .fill(LinearGradient(gradient:Gradient(colors: [Color.gray, Color.gray ]),startPoint: .center,endPoint: .trailing)
                             )
                        .frame(width: 40, height: 40)
                        .cornerRadius(15)
                        .opacity(0.3)
                        .shadow(color: .white, radius: 3, x: 2, y: 2)
                )
        })
    }
}

struct EditButtonView_Previews: PreviewProvider {
    static var previews: some View {
        EditButtonView(action: {})
    }
}
