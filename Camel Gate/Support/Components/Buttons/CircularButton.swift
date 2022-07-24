//
//  CircularButton.swift
//  Camel Gate
//
//  Created by wecancity on 23/07/2022.
//

import SwiftUI

struct CircularButton : View {
    var ButtonImage : Image
    var forgroundColor : Color?
    var backgroundColor : Color?
    var Buttonwidth : CGFloat?
    var Buttonheight : CGFloat?
    
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ButtonImage
                .resizable()
                .scaledToFit()
                .frame(width: Buttonwidth, height: Buttonheight)
        }
        
        .frame(width: Buttonheight! + 15, height: Buttonheight! + 15)
        .foregroundColor(forgroundColor)
        .background( backgroundColor)
        .clipShape(Circle())
    }
}

struct CircularButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            CircularButton(ButtonImage: Image("Pencil"), action: {})
        }
    }
}
