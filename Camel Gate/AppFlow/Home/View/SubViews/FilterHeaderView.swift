//
//  FilterHeaderView.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 7/23/22.
//

import SwiftUI

struct FilterHeaderView: View {
    var body: some View {
      HStack{
        Text("Nearest Shipments")
          .foregroundColor(Color.gray)
        Spacer()
        Button(action: {}) {
          Image("ic_filter")
            .resizable()
            .scaledToFit()
            .frame(width: 25 , height: 25)
        }
      }.padding()
    }
}

struct FilterHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        FilterHeaderView()
    }
}

