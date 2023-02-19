//
//  FontsExtension.swift
//  Camel Gate
//
//  Created by wecancity on 24/07/2022.
//

import SwiftUI

extension Font {

    static func camelLight(of size: CGFloat) -> Self {
        var language = LocalizationService.shared.language
        return Font.custom(language.rawValue == "en" ? "MyriadConceptRoman-Light":"GESSUniqueLight-Light", size: size)
     }

    static func camelRegular(of size: CGFloat) -> Self {
        var language = LocalizationService.shared.language
        return Font.custom(language.rawValue == "en" ? "MyriadConceptRoman-Regular":"GESSTextMedium-Medium", size: size)
     }
    static func camelsemiBold(of size: CGFloat) -> Self {
        var language = LocalizationService.shared.language
        return Font.custom(language.rawValue == "en" ? "MyriadConceptRoman-Semibold":"GESSUniqueBold-Bold", size: size)
     }
    static func camelBold(of size: CGFloat) -> Self {
        var language = LocalizationService.shared.language
        return Font.custom(language.rawValue == "en" ? "MyriadConceptRoman-Bold":"GESSUniqueBold-Bold", size: size)
     }

//    static func camelLightEn(of size: CGFloat) -> Self {
//         Font.custom("MyriadConceptRoman-Light", size: size)
//     }
//    static func camelRegularEn(of size: CGFloat) -> Self {
//         Font.custom("MyriadConceptRoman-Regular", size: size)
//     }
//    static func camelsemiBoldEn(of size: CGFloat) -> Self {
//         Font.custom("MyriadConceptRoman-Semibold", size: size)
//     }
//    static func camelBoldEn(of size: CGFloat) -> Self {
//         Font.custom("MyriadConceptRoman-Bold", size: size)
//     }
    
    
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
static let shared = CamelFonts()
        let LightAr11 = Font.custom("GESSUniqueLight-Light", size: 11)
        let LightAr12 = Font.custom("GESSUniqueLight-Light", size: 12)
        let LightAr14 = Font.custom("GESSUniqueLight-Light", size: 14)
        let LightAr16 = Font.custom("GESSUniqueLight-Light", size: 16)
        let LightAr18 = Font.custom("GESSUniqueLight-Light", size: 18)
        let LightAr20 = Font.custom("GESSUniqueLight-Light", size: 20)
        let LightAr22 = Font.custom("GESSUniqueLight-Light", size: 22)
        let LightAr24 = Font.custom("GESSUniqueLight-Light", size: 24)
//
        let RegAr9 = Font.custom("GESSTextMedium-Medium", size: 9)
        let RegAr11 = Font.custom("GESSTextMedium-Medium", size: 11)
        let RegAr12 = Font.custom("GESSTextMedium-Medium", size: 12)
        let RegAr14 = Font.custom("GESSTextMedium-Medium", size: 14)
        let RegAr16 = Font.custom("GESSTextMedium-Medium", size: 16)
        let RegAr18 = Font.custom("GESSTextMedium-Medium", size: 18)
        let RegAr20 = Font.custom("GESSTextMedium-Medium", size: 20)
        let RegAr22 = Font.custom("GESSTextMedium-Medium", size: 22)
        let RegAr24 = Font.custom("GESSTextMedium-Medium", size: 24)
//
        let BoldAr11 = Font.custom("GESSUniqueBold-Bold", size: 11)
        let BoldAr12 = Font.custom("GESSUniqueBold-Bold", size: 12)
        let BoldAr14 = Font.custom("GESSUniqueBold-Bold", size: 14)
        let BoldAr16 = Font.custom("GESSUniqueBold-Bold", size: 16)
        let BoldAr18 = Font.custom("GESSUniqueBold-Bold", size: 18)
        let BoldAr20 = Font.custom("GESSUniqueBold-Bold", size: 20)
        let BoldAr22 = Font.custom("GESSUniqueBold-Bold", size: 22)
        let BoldAr24 = Font.custom("GESSUniqueBold-Bold", size: 24)

        let SemiBoldAr11 = Font.custom("GESSUniqueBold-Bold", size: 11)
        let SemiBoldAr12 = Font.custom("GESSUniqueBold-Bold", size: 12)
        let SemiBoldAr14 = Font.custom("GESSUniqueBold-Bold", size: 14)
        let SemiBoldAr16 = Font.custom("GESSUniqueBold-Bold", size: 16)
        let SemiBoldAr18 = Font.custom("GESSUniqueBold-Bold", size: 18)
        let SemiBoldAr20 = Font.custom("GESSUniqueBold-Bold", size: 20)
        let SemiBoldAr22 = Font.custom("GESSUniqueBold-Bold", size: 22)
        let SemiBoldAr24 = Font.custom("GESSUniqueBold-Bold", size: 24)
        
        
        
        let Light11 = Font.custom("MyriadConceptRoman-Light", size: 11)
        let Light12 = Font.custom("MyriadConceptRoman-Light", size: 12)
        let Light14 = Font.custom("MyriadConceptRoman-Light", size: 14)
        let Light16 = Font.custom("MyriadConceptRoman-Light", size: 16)
        let Light18 = Font.custom("MyriadConceptRoman-Light", size: 18)
        let Light20 = Font.custom("MyriadConceptRoman-Light", size: 20)
        let Light22 = Font.custom("MyriadConceptRoman-Light", size: 22)
        let Light24 = Font.custom("MyriadConceptRoman-Light", size: 24)

        let Reg9 = Font.custom("MyriadConceptRoman-Regular", size: 9)
        let Reg11 = Font.custom("MyriadConceptRoman-Regular", size: 11)
        let Reg12 = Font.custom("MyriadConceptRoman-Regular", size: 12)
        let Reg14 = Font.custom("MyriadConceptRoman-Regular", size: 14)
        let Reg16 = Font.custom("MyriadConceptRoman-Regular", size: 16)
        let Reg18 = Font.custom("MyriadConceptRoman-Regular", size: 18)
        let Reg20 = Font.custom("MyriadConceptRoman-Regular", size: 20)
        let Reg22 = Font.custom("MyriadConceptRoman-Regular", size: 22)
        let Reg24 = Font.custom("MyriadConceptRoman-Regular", size: 24)

//        let Med11 = Font.custom("Myriad Roman Regular", size: 11)
//        let Med14 = Font.custom("Myriad Roman Regular", size: 14)
//        let Med16 = Font.custom("Myriad Roman Regular", size: 16)
//        let Med18 = Font.custom("Myriad Roman Regular", size: 18)
//        let Med20 = Font.custom("Myriad Roman Regular", size: 20)
//        let Med22 = Font.custom("Myriad Roman Regular", size: 22)
//        let Med24 = Font.custom("Myriad Roman Regular", size: 24)
        
        let Bold11 = Font.custom("MyriadConceptRoman-Bold", size: 11)
        let Bold12 = Font.custom("MyriadConceptRoman-Bold", size: 12)
        let Bold14 = Font.custom("MyriadConceptRoman-Bold", size: 14)
        let Bold16 = Font.custom("MyriadConceptRoman-Bold", size: 16)
        let Bold18 = Font.custom("MyriadConceptRoman-Bold", size: 18)
        let Bold20 = Font.custom("MyriadConceptRoman-Bold", size: 20)
        let Bold22 = Font.custom("MyriadConceptRoman-Bold", size: 22)
        let Bold24 = Font.custom("MyriadConceptRoman-Bold", size: 24)

        let SemiBold11 = Font.custom("MyriadConceptRoman-Semibold", size: 11)
        let SemiBold12 = Font.custom("MyriadConceptRoman-Semibold", size: 12)
        let SemiBold14 = Font.custom("MyriadConceptRoman-Semibold", size: 14)
        let SemiBold16 = Font.custom("MyriadConceptRoman-Semibold", size: 16)
        let SemiBold18 = Font.custom("MyriadConceptRoman-Semibold", size: 18)
        let SemiBold20 = Font.custom("MyriadConceptRoman-Semibold", size: 20)
        let SemiBold22 = Font.custom("MyriadConceptRoman-Semibold", size: 22)
        let SemiBold24 = Font.custom("MyriadConceptRoman-Semibold", size: 24)
    }
    static let camelfonts = CamelFonts()

}

//MARK: -- to use this custom font
// ("your Text") .font(Font.camelfonts.Bold16)

