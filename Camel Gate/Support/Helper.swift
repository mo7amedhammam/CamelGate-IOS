//
//  Helper.swift
//  SalamTech
//
//  Created by wecancity agency on 3/29/22.
//

import Foundation
import SystemConfiguration
import UIKit
import SwiftUI
import CoreLocation

final class Helper{
    static let userDef = UserDefaults.standard
    
    var Id           = 0
    var clinicId     = 0
    var DriverName = ""
    var DriverImage = ""
    var Image = ""
    var CurrentLatitude = ""
    var CurrentLongtude = ""
    var CurrentAddress = ""
    var currentLanguage = ""
    private static let onBoardKey = "onBoard"
    private static let LoggedInKey = "LoggedId"

    class func setUserData(
//        Id : Int,
    DriverName : String,
        DriverImage : String
    ){
//        userDef.set(  Id             , forKey:  "Id" )
        userDef.set(  DriverName         , forKey: "DriverName"  )
        userDef.set(  DriverImage         , forKey: "DriverImage"  )

        userDef.synchronize()
    }
    
    //for checking if user exist
    class func userExist()->Bool{
        return userDef.string(forKey: "DriverName") != nil || userDef.string(forKey: "DriverName") != ""
    }
    
    class func getDriverName() ->String {
        return userDef.string(forKey: "DriverName") ?? ""
    }
    
    class func getDriverimage() ->String {
        return userDef.string(forKey: "DriverImage") ?? ""
    }
    
        class func setClinicId(clinicId: Int) {
        userDef.set(clinicId, forKey: "clinicId")
        userDef.synchronize()
    }
        class func getClinicId()->Int{
        return userDef.integer(forKey: "clinicId")
    }
    class func setLanguage(currentLanguage: String) {
    userDef.set(currentLanguage, forKey: "languagekey")
    userDef.synchronize()
    }
    class func getLanguage()->String{
    return userDef.string(forKey: "languagekey") ?? "en"
    }
    
    //save access token
    class func setAccessToken(access_token : String) {
        userDef.set(access_token, forKey: "access_token")
        userDef.synchronize()
    }

    class func getAccessToken()->String{
        return userDef.string(forKey: "access_token") ?? "token default"
    }
    //remove data then logout
    class func logout() {
//        userDef.removeObject(forKey:"Id"  )
        Helper.IsLoggedIn(value: false)
        userDef.removeObject(forKey:"DriverName"  )
        userDef.removeObject(forKey:"DriverImage"  )
        userDef.removeObject(forKey:"Image"  )
        userDef.removeObject(forKey:"access_token"  )
        userDef.removeObject(forKey: "clinicId")
    }
    
    static func onBoardOpened() {
        UserDefaults.standard.set(true, forKey: onBoardKey)
    }

    static func checkOnBoard() -> Bool {
        return UserDefaults.standard.bool(forKey: onBoardKey)
    }
    static func IsLoggedIn(value:Bool) {
        UserDefaults.standard.set(value, forKey: LoggedInKey)
    }

    static func CheckIfLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: LoggedInKey)
    }
    
    class func changeLang() {
        userDef.removeObject(forKey:"language"  )
    }
    
    // navigate to google maps with lond & lat
    class func openGoogleMap(longitude: Double, latitude: Double) {
            let appURL = NSURL(string: "comgooglemaps://?daddr=\(latitude),\(longitude)&directionsmode=driving")!
            let webURL = NSURL(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving")!
            let application = UIApplication.shared
            
            if application.canOpenURL(appURL as URL) {
                application.open(appURL as URL)
                print(appURL)
            } else {
                // if GoogleMaps app is not installed, open URL inside Safari
                application.open(webURL as URL)
            }
           }
        
    // Checking internet connection
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
        
    }
    
    // Starting Phone call
    class func MakePhoneCall(PhoneNumber:String){
        let phone = "tel://"
        let phoneFormatted = phone + PhoneNumber
        guard let url = URL(string: phoneFormatted) else {return}
        UIApplication.shared.open(url)
    }
    
    
    
}


// navigate to google maps with lond & lat
func openWhatsApp(number : String?) {
    var fullMob = number ?? "+966505896222"
    fullMob = fullMob.replacingOccurrences(of: " ", with: "")
    fullMob = fullMob.replacingOccurrences(of: "+", with: "")
    fullMob = fullMob.replacingOccurrences(of: "-", with: "")
        let appURL = NSURL(string: "whatsapp://send?phone=\(fullMob)")!

        let webURL = NSURL(string: "https://web.whatsapp.com/send?phone=\(fullMob)")!
    let application = UIApplication.shared
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
            print(appURL)
        } else {
            // if GoogleMaps app is not installed, open URL inside Safari
            application.open(webURL as URL)
        }
       }

//@AppStorage("language")
//var language = LocalizationService.shared.language

func ChangeFormate( NewFormat:String) -> DateFormatter {
//    @AppStorage("language")
//    var language = LocalizationService.shared.language
    let df = DateFormatter()
    df.dateFormat = NewFormat
//    df.locale = Locale(identifier: language.rawValue == "ar" ? "ar":"en_US_POSIX")
    return df
}

// change Format From String to String
func ConvertStringDate(inp:String, FormatFrom:String, FormatTo:String) -> String {
    @AppStorage("language")
    var language = LocalizationService.shared.language
    
    var newdate = ""
    let formatter = DateFormatter()
//    formatter.locale = Locale(identifier: language.rawValue == "ar" ? "ar":"en_US_POSIX")

    formatter.dateFormat = FormatFrom
    if let date = formatter.date(from: inp) {
//        print(date)
        formatter.dateFormat = FormatTo
        newdate = formatter.string(from: date)
    }
 return newdate
  }

// change Format From date to date
func ConvertDateFormat(inp:Date, FormatTo:String) -> Date {
    @AppStorage("language")
    var language = LocalizationService.shared.language
    
    var newdate = Date()
        let formatter = DateFormatter()
    let date = formatter.string(from: inp )
//    formatter.locale = Locale(identifier: language.rawValue == "ar" ? "ar":"en_US_POSIX")
        formatter.dateFormat = FormatTo
        newdate = formatter.date(from: date) ?? Date()
    
 return newdate
  }


//extension UIDevice {
    var hasNotch: Bool
    {
        if #available(iOS 11.0, *)
        {
            let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            return bottom > 0
        } else
        {
            // Fallback on earlier versions
            return false
        }
    }
//}

enum ActiveAlert {
    case NetworkError, serverError, success, unauthorized
}

enum InvalidFields {
    case none, PhoneNumber, Password, ConfirmPassword, Name, Email, unauthorized, DriverLicense, TruckLicense, ResidentId
}


func convDateToDate(input: String, format:String) -> Date {
    @AppStorage("language")
    var language = LocalizationService.shared.language
    var newdate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
//    dateFormatter.locale = Locale(identifier: language.rawValue == "ar" ? "ar":"en_US_POSIX")

    if let newDate = dateFormatter.date(from: input) {
        newdate = newDate
    } else{
        print(" can't convert ")
    }
    return newdate
}
