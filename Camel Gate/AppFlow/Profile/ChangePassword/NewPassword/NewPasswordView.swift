//
//  NewPasswordView.swift
//  Camel Gate
//
//  Created by wecancity on 25/07/2022.
//

import SwiftUI

struct NewPasswordView: View {
    var body: some View {
        ZStack{
         
            TitleBar(Title: "Change_Password", navBarHidden: true, leadingButton: .backButton ,trailingAction: {
            })
        }.background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))

    }
}

struct NewPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        NewPasswordView()
    }
}
