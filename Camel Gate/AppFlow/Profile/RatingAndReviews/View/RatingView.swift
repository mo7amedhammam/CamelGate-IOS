//
//  RatingView.swift
//  Camel Gate
//
//  Created by wecancity on 24/07/2022.
//

import SwiftUI

struct RatingView: View {
    var language = LocalizationService.shared.language

    var body: some View {
        ZStack{
            ScrollView{
                ForEach(0...5,id:\.self){ _ in
                ShipmentRateCell()
                }
                .padding(.top)
            }.padding(.top,hasNotch ? 100:115)
            
            TitleBar(Title: "Rating_&_Reviews".localized(language), navBarHidden: true, leadingButton: .backButton, IsSubTextRate: true,subText: "4.5", trailingAction: {})

        }
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            RatingView()
        }
        ZStack {
            RatingView()
        }.previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
    }
}

