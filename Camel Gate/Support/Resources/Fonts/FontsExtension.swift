//
//  FontsExtension.swift
//  Camel Gate
//
//  Created by wecancity on 24/07/2022.
//

import SwiftUI

extension Font {
    struct CamelFonts {

        let Reg11 = Font.custom("SFUIText-Regular", size: 11)
        let Reg14 = Font.custom("SFUIText-Regular", size: 14)
        let Reg16 = Font.custom("SFUIText-Regular", size: 16)
        let Reg18 = Font.custom("SFUIText-Regular", size: 18)
        let Reg20 = Font.custom("SFUIText-Regular", size: 20)
        let Reg22 = Font.custom("SFUIText-Regular", size: 22)
        let Reg24 = Font.custom("SFUIText-Regular", size: 24)

        let Med11 = Font.custom("SFUIText-Medium", size: 11)
        let Med14 = Font.custom("SFUIText-Medium", size: 14)
        let Med16 = Font.custom("SFUIText-Medium", size: 16)
        let Med18 = Font.custom("SFUIText-Medium", size: 18)
        let Med20 = Font.custom("SFUIText-Medium", size: 20)
        let Med22 = Font.custom("SFUIText-Medium", size: 22)
        let Med24 = Font.custom("SFUIText-Medium", size: 24)
        
        
        let Bold11 = Font.custom("SFUIText-Bold", size: 11)
        let Bold14 = Font.custom("SFUIText-Bold", size: 14)
        let Bold16 = Font.custom("SFUIText-Bold", size: 16)
        let Bold18 = Font.custom("SFUIText-Bold", size: 18)
        let Bold20 = Font.custom("SFUIText-Bold", size: 20)
        let Bold22 = Font.custom("SFUIText-Bold", size: 22)
        let Bold24 = Font.custom("SFUIText-Bold", size: 24)

        let SemiBold11 = Font.custom("SFUIText-Semibold", size: 11)
        let SemiBold14 = Font.custom("SFUIText-Semibold", size: 14)
        let SemiBold16 = Font.custom("SFUIText-Semibold", size: 16)
        let SemiBold18 = Font.custom("SFUIText-Semibold", size: 18)
        let SemiBold20 = Font.custom("SFUIText-Semibold", size: 20)
        let SemiBold22 = Font.custom("SFUIText-Semibold", size: 22)
        let SemiBold24 = Font.custom("SFUIText-Semibold", size: 24)
    }
    static let camelfonts = CamelFonts()
}

//MARK: -- to use this custom font
// ("your Text") .font(Font.camelfonts.Bold16)

