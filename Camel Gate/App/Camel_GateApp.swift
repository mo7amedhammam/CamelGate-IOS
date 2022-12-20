//
//  Camel_GateApp.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 7/17/22.
//

import SwiftUI
import FirebaseCore

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
            
            
//                .environment(\.locale, Locale(identifier: language.rawValue == "ar" ? "ar":"en_US_POSIX"))
//                .environment(\.layoutDirection, .rightToLeft)
//                .onAppear(perform: {
//                    print(language.rawValue)
//                    print("local\(Locale.preferredLanguages)")
//                })
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
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
