//
//  Camel_GateApp.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 7/17/22.
//

import SwiftUI
import FirebaseCore

let GbaseUrl = "https://maps.googleapis.com/maps/api/geocode/json?"
let Gapikey = "AIzaSyAy8wLUdHfHVmzlWLNPVF96SO0GY1gP4Po"

let numberformatter : NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.minimumFractionDigits = 1
//    formatter.locale =  Locale(identifier: "en_US")
    return formatter
}()

@main
struct Camel_GateApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var language = LocalizationService.shared.language
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }.navigationViewStyle(.stack)
//                .environment(\.locale, Locale(identifier : "en_US_POSIX"))
//                .environment(\.locale, .init(identifier: "en"))
//                .environment(\.locale, .init(identifier: "ar"))

        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      
//      UserDefaults.standard.set("EN", forKey: "AppleLanguage")

    return true
  }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
                UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
#endif
