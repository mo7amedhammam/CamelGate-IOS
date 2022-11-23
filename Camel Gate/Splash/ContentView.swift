//
//  SplashView.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 7/18/22.
//

import SwiftUI

struct ContentView: View {
//    @AppStorage("language")
//    var language = LocalizationService.shared.language

    @State var displayedView = AnyView(SplashScreenView())
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        ZStack {
            displayedView.navigationBarHidden(true)
        }
        .onAppear {
            delaySegue()
//            setFirstLanguage()
        }
        
        .onChange(of: scenePhase, perform: { newPhase in
            if newPhase == .active {
                print("Active")
            } else if newPhase == .inactive {
                print("InActive")
            } else if newPhase == .background {
                print("BackGround")
            }
        })
        .navigationViewStyle(StackNavigationViewStyle())
        .preferredColorScheme(.light)
    }
    
    private func delaySegue() {
        // Delay of 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            // first check in its the first time
            guard Helper.checkOnBoard() else {
                withAnimation{
                    displayedView = AnyView(OnBoardingView())
                }
                return
            }
            // second check if user is logedin or not
            guard Helper.CheckIfLoggedIn() else{
                withAnimation{
                    displayedView = AnyView(SignInView())
                }
                return
            }
            // finally
            withAnimation{
                displayedView = AnyView(TabBarView())
            }
        }
    }
    
    
    private func setFirstLanguage()  {
            if Helper.getLanguage() != ""{
                print(Helper.getLanguage())
//                LocalizationService.shared.language =  Language( rawValue: Locale.current.languageCode ?? "en" ) ?? .english_us
                language = Language( rawValue: Locale.current.languageCode ?? "en" ) ?? .english_us
                Helper.setLanguage(currentLanguage: Locale.current.languageCode ?? "en")
          }
            print(Helper.getLanguage())
        }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


