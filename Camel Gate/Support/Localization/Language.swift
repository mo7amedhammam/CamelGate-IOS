//
//  Language.swift
//  SalamTech
//
//  Created by wecancity agency on 3/29/22.
//

import Foundation

enum Language: String {
    case english_us = "en"
    case arabic = "ar"
    
    var userSymbol: String {
        switch self {
        case .english_us:
            return "us"
        case .arabic:
            return "eg"
        }
    }
}
