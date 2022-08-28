//
//  TabButton.swift
//  Camel Gate
//
//  Created by wecancity on 21/07/2022.
//

import SwiftUI

// Tab Button...
struct TabButton : View {
    var language = LocalizationService.shared.language

  var title : String
  @Binding var selectedTab : String
    var animation : Namespace.ID

  var body: some View{
    Button(action: {
        withAnimation{selectedTab = title}
    }) {
      VStack(spacing: 6){
        ZStack{
          CustomShape()
            .fill(Color.clear)
            .frame(width: 45, height: 6)

          if selectedTab == title{
            CustomShape()
              .fill(Color("Base_Color"))
              .frame(width: 60, height: 6)
              .matchedGeometryEffect(id: "Tab_Change", in: animation)
              .shadow(color: Color("Base_Color").opacity(0.5), radius: 8, x: 0, y: 5)
          }
        }
        .padding(.bottom,10)

        Image(title)
          .renderingMode(.template)
          .resizable()
          .foregroundColor(selectedTab == title ? Color("Second_Color") : Color.black.opacity(0.2))
          .frame(width: 24, height: 24)

          Text(title.localized(language))
                .font( language.rawValue == "ar" ? Font.camelfonts.RegAr12:Font.camelfonts.Reg12)

              .foregroundColor(Color("Base_Color")
                                .opacity(selectedTab == title ? 1.0 : 0.2))
      }
    }
  }
}

struct TabButton_Previews: PreviewProvider {
    static var previews: some View {
        TabButton(title: "Home", selectedTab: .constant("Home"), animation: Namespace().wrappedValue)
    }
}


//MARK: --- Custom Shape..
struct CustomShape : Shape {
  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 10, height: 10))
    return Path(path.cgPath)
  }
}
