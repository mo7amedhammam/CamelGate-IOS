//
//  DateFormatsExt.swift
//  Camel Gate
//
//  Created by wecancity on 11/08/2022.
//

import Foundation

extension String{
    func StrToDate(format:String = "yyyy/MM/dd HH:mm:ss")->Date{
//        var language = LocalizationService.shared.language

        var cbDate:Date = Date()
        if(!self.isEmpty){
            let dateFormatter=DateFormatter()
            dateFormatter.dateFormat=format
            let tmpDate = dateFormatter.date(from: self)
            if let tmpDate = tmpDate{
                cbDate = tmpDate
            }
        }
        return cbDate
    }
}

extension Date{
    func DateToStr(format:String = "yyyy/MM/dd HH:mm:ss",isPost:Bool=false)->String{
//        var language = LocalizationService.shared.language

        let timeFormatter = DateFormatter()
//        timeFormatter.locale = Locale(identifier: LocalizationService.shared.language == .english_us ? "en_US_POSIX":isPost==true ? "en_US_POSIX": "ar")

//        timeFormatter.locale = Locale.current
//        timeFormatter.timeZone = TimeZone.current
        timeFormatter.dateFormat = format
        
        let nowTimestr = timeFormatter.string(from: self)
        return nowTimestr
    }
}
