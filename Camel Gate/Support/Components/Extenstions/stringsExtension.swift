//
//  stringsExtension.swift
//  Camel Gate
//
//  Created by wecancity on 10/02/2023.
//

import Foundation
extension String {
    func isValidEmail() -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailValidation = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
            return emailValidation.evaluate(with: self)
        }
}
