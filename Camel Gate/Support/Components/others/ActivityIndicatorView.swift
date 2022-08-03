//
//  ActivityIndicatorView.swift
//  Camel Gate
//
//  Created by wecancity on 03/08/2022.
//

import SwiftUI

struct ActivityIndicatorView: View {
    @Binding var isPresented:Bool?
//    @State var loadingTitle : LoadingType?
     var body: some View {
         if isPresented ?? false{
            ZStack {
                ZStack{
                        ProgressView {
                        }
                        .frame(width: 120, height: 120)
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                        .scaleEffect(1.5 , anchor: .center)
                        .background(Color.black.opacity(0.55)).cornerRadius(20)
                    }
                    .background(Color.gray.opacity(0.1).blur(radius: 20))
                .edgesIgnoringSafeArea(.all)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // 1
                .background(Color.black.opacity(0.1))

            }
                   
    }
}

struct ActivityIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorView(isPresented: .constant(true))
    }
}
