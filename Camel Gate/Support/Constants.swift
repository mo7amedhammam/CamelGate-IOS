//
//  Constants.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 02/08/2022.
//

import Foundation

struct Constants {


    // MARK: - Network response status
    static var success:Int {return 200}
    static var added:Int {return 202}
    static var failed:Int {return 400}
    static var created:Int {return 201}
    static var unprocessableEntity : Int {return 401}
    static var notActive : Int {return 401}
    static var unauthenticated : Int {return 401}
    static var notAcceptable : Int {return 401}
    static var notFound : Int {return 404}
    static var userType : Int {return 1}

    // MARK: - GOOGLE MAPS Constants
    static var mapKey : String {return "AIzaSyCjsvKLJRP5P00s2xMRbJKWIQ2bCifh9bs"}
    static var mapStyle : String {return "&zoom=11&style=feature:transit.line%7Cvisibility:simplified%7Ccolor:0xbababa&style=feature:road.highway%7Celement:labels.text.stroke%7Cvisibility:on%7Ccolor:0xb06eba&style=feature:road.highway%7Celement:labels.text.fill%7Cvisibility:on%7Ccolor:0xffffff&maptype=terrain&scale=2&size=400x400&"}

    // MARK: - APIs Constants
    static var baseURL:String {return "https://camelgateapi.wecancity.com/"} //TEST
//    static var baseURL:String {return "https://camelgatedashboard.azurewebsites.net/"} //LIVE

    static var apiURL:String {return "\(baseURL)api/\(Helper.getLanguage())"}
//    static var imagesURL:String {return "http://camelgateapi.wecancity.com/"}
    
    var TermsAndConditionsURL =  "https://camelgate.app/terms.html"

}
