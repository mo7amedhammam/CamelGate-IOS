//
//  stringsExtension.swift
//  Camel Gate
//
//  Created by wecancity on 10/02/2023.
//

import Foundation
extension String {
    
    
//    func formatAsEnglishNumber() -> String {
//            let formatter = NumberFormatter()
//            formatter.locale = Locale(identifier: "en_US")
//            return formatter.string(from: NumberFormatter().number(from: self) ?? 0) ?? ""
//        }

    
    
    
    func isValidEmail() -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailValidation = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
            return emailValidation.evaluate(with: self)
        }
    
//    func replacedArabicDigitsWithEnglish()-> String{
//        let numberFormatter = NumberFormatter()
//        numberFormatter.locale = Locale(identifier: "en")
//        let engNumber = numberFormatter.number(from: self)
//        print("\(engNumber ?? 0)")
//        return "\(engNumber ?? 0)"
//    }
//
//    /// To convert English numbers to Arabic / Persian
//    /// - Returns: returns Arabic number
//    func replacedEnglishDigitsWithArabic()-> String{
//        let numberFormatter = NumberFormatter()
//        numberFormatter.locale = Locale(identifier: "ar")
//        let arabicNumber = numberFormatter.number(from: self)
//        print("\(arabicNumber ?? 0)")
//        return "\(arabicNumber ?? 0)"
//    }
    
    
    
    func replacedArabicDigitsWithEnglish() -> String {
    var str = self
    let map = ["٠": "0",
               "١": "1",
               "٢": "2",
               "٣": "3",
               "٤": "4",
               "٥": "5",
               "٦": "6",
               "٧": "7",
               "٨": "8",
               "٩": "9"]
    map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
    return str
}
    func replacedEnglishDigitsWithArabic() -> String {
    var str = self
    let map = ["0": "٠",
               "1": "١",
               "2": "٢",
               "3": "٣",
               "4": "٤",
               "5": "٥",
               "6": "٦",
               "7": "٧",
               "8": "٨",
               "9": "٩"]
    map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
    return str
}
    
}
