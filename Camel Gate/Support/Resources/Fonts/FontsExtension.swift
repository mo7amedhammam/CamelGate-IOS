//
//  FontsExtension.swift
//  Camel Gate
//
//  Created by wecancity on 24/07/2022.
//

import SwiftUI

extension Font {

    struct CamelFonts {
        
//        MARK: -- arabic --
//        GESSUniqueLight-Light
//        GESSTextMedium-Medium
//        GESSUniqueBold-Bold
        
//        MARK: -- english --
//        "MyriadConceptRoman-Regular"
//        "MyriadConceptRoman-Light"
//        "MyriadConceptRoman-Semibold"
//        "MyriadConceptRoman-Bold"
//
//        let LightAr11 = Font.custom("GESSUniqueLight-Light", size: 11)
//        let LightAr14 = Font.custom("GESSUniqueLight-Light", size: 14)
//        let LightAr16 = Font.custom("GESSUniqueLight-Light", size: 16)
//        let LightAr18 = Font.custom("GESSUniqueLight-Light", size: 18)
//        let LightAr20 = Font.custom("GESSUniqueLight-Light", size: 20)
//        let LightAr22 = Font.custom("GESSUniqueLight-Light", size: 22)
//        let LightAr24 = Font.custom("GESSUniqueLight-Light", size: 24)
//
//        let MedAr11 = Font.custom("GESSTextMedium-Medium", size: 11)
//        let MedAr14 = Font.custom("GESSTextMedium-Medium", size: 14)
//        let MedAr16 = Font.custom("GESSTextMedium-Medium", size: 16)
//        let MedAr18 = Font.custom("GESSTextMedium-Medium", size: 18)
//        let MedAr20 = Font.custom("GESSTextMedium-Medium", size: 20)
//        let MedAr22 = Font.custom("GESSTextMedium-Medium", size: 22)
//        let MedAr24 = Font.custom("GESSTextMedium-Medium", size: 24)
//
//        let BoldAr11 = Font.custom("GESSUniqueBold-Bold", size: 11)
//        let BoldAr14 = Font.custom("GESSUniqueBold-Bold", size: 14)
//        let BoldAr16 = Font.custom("GESSUniqueBold-Bold", size: 16)
//        let BoldAr18 = Font.custom("GESSUniqueBold-Bold", size: 18)
//        let BoldAr20 = Font.custom("GESSUniqueBold-Bold", size: 20)
//        let BoldAr22 = Font.custom("GESSUniqueBold-Bold", size: 22)
//        let BoldAr24 = Font.custom("GESSUniqueBold-Bold", size: 24)
        
        let Light11 = Font.custom( language.rawValue == "ar" ? "GESSUniqueLight-Light":"MyriadConceptRoman-Light", size: 11)
        let Light14 = Font.custom(language.rawValue == "ar" ? "GESSUniqueLight-Light":"MyriadConceptRoman-Light", size: 14)
        let Light16 = Font.custom(language.rawValue == "ar" ? "GESSUniqueLight-Light":"MyriadConceptRoman-Light", size: 16)
        let Light18 = Font.custom(language.rawValue == "ar" ? "GESSUniqueLight-Light":"MyriadConceptRoman-Light", size: 18)
        let Light20 = Font.custom(language.rawValue == "ar" ? "GESSUniqueLight-Light":"MyriadConceptRoman-Light", size: 20)
        let Light22 = Font.custom(language.rawValue == "ar" ? "GESSUniqueLight-Light":"MyriadConceptRoman-Light", size: 22)
        let Light24 = Font.custom(language.rawValue == "ar" ? "GESSUniqueLight-Light":"MyriadConceptRoman-Light", size: 24)

        let Reg11 = Font.custom(language.rawValue == "ar" ? "GESSTextMedium-Medium":"MyriadConceptRoman-Regular", size: 11)
        let Reg14 = Font.custom(language.rawValue == "ar" ? "GESSTextMedium-Medium":"MyriadConceptRoman-Regular", size: 14)
        let Reg16 = Font.custom(language.rawValue == "ar" ? "GESSTextMedium-Medium":"MyriadConceptRoman-Regular", size: 16)
        let Reg18 = Font.custom(language.rawValue == "ar" ? "GESSTextMedium-Medium":"MyriadConceptRoman-Regular", size: 18)
        let Reg20 = Font.custom(language.rawValue == "ar" ? "GESSTextMedium-Medium":"MyriadConceptRoman-Regular", size: 20)
        let Reg22 = Font.custom(language.rawValue == "ar" ? "GESSTextMedium-Medium":"MyriadConceptRoman-Regular", size: 22)
        let Reg24 = Font.custom(language.rawValue == "ar" ? "GESSTextMedium-Medium":"MyriadConceptRoman-Regular", size: 24)

//        let Med11 = Font.custom("Myriad Roman Regular", size: 11)
//        let Med14 = Font.custom("Myriad Roman Regular", size: 14)
//        let Med16 = Font.custom("Myriad Roman Regular", size: 16)
//        let Med18 = Font.custom("Myriad Roman Regular", size: 18)
//        let Med20 = Font.custom("Myriad Roman Regular", size: 20)
//        let Med22 = Font.custom("Myriad Roman Regular", size: 22)
//        let Med24 = Font.custom("Myriad Roman Regular", size: 24)
        
        let Bold11 = Font.custom(language.rawValue == "ar" ? "GESSUniqueBold-Bold":"MyriadConceptRoman-Bold", size: 11)
        let Bold14 = Font.custom(language.rawValue == "ar" ? "GESSUniqueBold-Bold":"MyriadConceptRoman-Bold", size: 14)
        let Bold16 = Font.custom(language.rawValue == "ar" ? "GESSUniqueBold-Bold":"MyriadConceptRoman-Bold", size: 16)
        let Bold18 = Font.custom(language.rawValue == "ar" ? "GESSUniqueBold-Bold":"MyriadConceptRoman-Bold", size: 18)
        let Bold20 = Font.custom(language.rawValue == "ar" ? "GESSUniqueBold-Bold":"MyriadConceptRoman-Bold", size: 20)
        let Bold22 = Font.custom(language.rawValue == "ar" ? "GESSUniqueBold-Bold":"MyriadConceptRoman-Bold", size: 22)
        let Bold24 = Font.custom(language.rawValue == "ar" ? "GESSUniqueBold-Bold":"MyriadConceptRoman-Bold", size: 24)

        let SemiBold11 = Font.custom(language.rawValue == "ar" ? "GESSUniqueBold-Bold":"MyriadConceptRoman-Semibold", size: 11)
        let SemiBold14 = Font.custom(language.rawValue == "ar" ? "GESSUniqueBold-Bold":"MyriadConceptRoman-Semibold", size: 14)
        let SemiBold16 = Font.custom(language.rawValue == "ar" ? "GESSUniqueBold-Bold":"MyriadConceptRoman-Semibold", size: 16)
        let SemiBold18 = Font.custom(language.rawValue == "ar" ? "GESSUniqueBold-Bold":"MyriadConceptRoman-Semibold", size: 18)
        let SemiBold20 = Font.custom(language.rawValue == "ar" ? "GESSUniqueBold-Bold":"MyriadConceptRoman-Semibold", size: 20)
        let SemiBold22 = Font.custom(language.rawValue == "ar" ? "GESSUniqueBold-Bold":"MyriadConceptRoman-Semibold", size: 22)
        let SemiBold24 = Font.custom(language.rawValue == "ar" ? "GESSUniqueBold-Bold":"MyriadConceptRoman-Semibold", size: 24)
    }
    static let camelfonts = CamelFonts()
}

//MARK: -- to use this custom font
// ("your Text") .font(Font.camelfonts.Bold16)

