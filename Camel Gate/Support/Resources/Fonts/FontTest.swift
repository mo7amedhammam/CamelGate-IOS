//
//  FontTest.swift
//  Camel Gate
//
//  Created by wecancity on 17/08/2022.
//

import SwiftUI

struct FontTest: View {
    var body: some View {
        Text("العربية")
            .font(Font.custom("GESSTextMedium-Medium", size: 60,relativeTo: .body))
    }
}

struct FontTest_Previews: PreviewProvider {
    static var previews: some View {
        FontTest()
    }
}
