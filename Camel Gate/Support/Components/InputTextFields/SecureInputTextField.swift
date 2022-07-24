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
    
    init(_ title: String, text: Binding<String>) {
        self.placeholder = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Group{
            if isSecured {
                SecureField(placeholder, text: $text)
                
            } else {
                TextField(placeholder, text: $text)
            }
            }    .autocapitalization(.none)
                .frame(width: screenWidth, height: 30 , alignment: .trailing)
                .font(.system(size: 13))
                .padding(12)
                .disableAutocorrection(true)
                .background(
                    Color.white
                )
                .cornerRadius(5)
                .shadow(color: Color.gray.opacity(0.099), radius: 3)
            
            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(.gray)
                    .padding()
            }
        }
    }
}

struct SecureInputTextField_Previews: PreviewProvider {
    static var previews: some View {
        SecureInputTextField("Password", text: .constant(""))
    }
}




