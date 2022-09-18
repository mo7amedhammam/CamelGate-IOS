//
//  SecureInputTextField.swift
//  Camel Gate
//
//  Created by wecancity on 24/07/2022.
//

import SwiftUI

struct SecureInputTextField: View {
    private var placeholder: String
    @Binding private var text: String
    @State private var isSecured: Bool = true
    let screenWidth = UIScreen.main.bounds.size.width - 50
    var iconName = ""

    init(_ title: String, text: Binding<String>,iconName:String) {
        self.placeholder = title
        self._text = text
        self.iconName =  iconName
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            
            HStack {
                if iconName != "" || iconName.isEmpty {
                Image(iconName)
                    .foregroundColor(Color("blueColor"))
                    .font(.system(size: 15))
                }
                Group{
                if isSecured {
                    SecureField(placeholder, text: $text)
                        .textContentType(.password)
                    
                } else {
                    TextField(placeholder, text: $text)
                }
                }
            }
                .autocapitalization(.none)
                .textInputAutocapitalization(.never)
                    .frame( height: 30 , alignment: .trailing)
                    .font(.system(size: 13))
                    .padding(12)
                    .disableAutocorrection(true)
                    .background(
                        Color.white
                    )
                    .cornerRadius(5)
                .shadow(color: Color.black.opacity(0.099), radius: 3)
            

            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(.gray.opacity(0.5))
                    .padding()
            }
        }
    }
}

struct SecureInputTextField_Previews: PreviewProvider {
    static var previews: some View {
        SecureInputTextField("Password", text: .constant(""), iconName: "")
    }
}




