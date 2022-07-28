//
//  XButton.swift
//  Camel Gate
//
//  Created by wecancity on 28/07/2022.
//

import SwiftUI

struct XButton: View {
        @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
        var body: some View {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("x")
//                    .renderingMode(.original)
                    .foregroundColor(.white)
//                    .padding()
                    .font(.system(size: 25, weight: .bold))
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

    struct XButton_Previews: PreviewProvider {
        static var previews: some View {
            XButton().previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
        }
    }
