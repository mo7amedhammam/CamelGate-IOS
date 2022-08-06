//
//  InputTextField.swift
//  Camel Gate
//
//  Created by wecancity on 24/07/2022.
//
import SwiftUI

struct InputTextField: View {
    @State var iconName : String? = ""
    @State var iconColor : Color? = .clear

    var placeholder : String

    @Binding var text: String
    let screenWidth = UIScreen.main.bounds.size.width - 55
    var body: some View {
        
        HStack{
            if iconName != "" || iconName != nil{
                Image(iconName ?? "")
                    .renderingMode( iconColor != .clear ? .template:.original)
//                    .foregroundColor(.secondary)
//                    .tint(.gray)
//                    .background(Color.white)
                    .foregroundColor(iconColor == .clear ? .clear:iconColor)
                    .font(.system(size: 15))
            }else{
            }
            
            ZStack (alignment:.leading){
                Text(placeholder)
                    .font(Font.camelfonts.Reg14)
                    .foregroundColor(.gray.opacity(0.5))
                    .offset(y: text.isEmpty ? 0 : -20)
                    .scaleEffect(text.isEmpty ? 1 : 0.8, anchor: .leading)
                
                TextField("",text:$text)
                    .font(Font.camelfonts.Reg16)
                    .autocapitalization(.none)
                    .textInputAutocapitalization(.never)
            }
        }
        .frame( height: 30)
        .padding(12)
        .disableAutocorrection(true)
        .background(
            Color.white
        )
            .cornerRadius(5)
            .shadow(color: Color.black.opacity(0.099), radius: 3)
        
    }
}
struct InputTextField_Previews: PreviewProvider {
    static var previews: some View {
        InputTextField(iconName:"x321gray",placeholder: "Name", text: .constant("Mohamed Hammam"))
        
    }
}

