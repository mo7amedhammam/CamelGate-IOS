//
//  InputTextField.swift
//  Camel Gate
//
//  Created by wecancity on 24/07/2022.
//
import SwiftUI

struct InputTextField: View {
    @State var imagename : String? = "cargo"
    var placeholder : String

    @Binding var text: String
    let screenWidth = UIScreen.main.bounds.size.width - 55
    var body: some View {
        
        HStack{
            if imagename != "" || imagename != nil{
                Image(imagename ?? "")
//                    .renderingMode(.template)
//                    .foregroundColor(.secondary)
//                    .tint(.gray)
//                    .background(Color.white)
            }else{
            }
            
            ZStack (alignment:.leading){
                Text(placeholder)
                    .font(Font.camelfonts.Reg14)
                    .foregroundColor(.gray)
                    .offset(y: text.isEmpty ? 0 : -20)
                    .scaleEffect(text.isEmpty ? 1 : 0.8, anchor: .leading)
                
                TextField("",text:$text)
                    .font(Font.camelfonts.Reg16)
                    .autocapitalization(.none)
                    .textInputAutocapitalization(.none)
            }
        }
        .frame(width: screenWidth, height: 30)
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
        InputTextField(imagename:"x321gray",placeholder: "Name", text: .constant("Mohamed Hammam"))
        
    }
}
