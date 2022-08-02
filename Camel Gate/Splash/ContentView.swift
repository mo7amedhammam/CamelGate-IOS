//
//  SplashView.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 7/18/22.
//

import SwiftUI

struct ContentView: View {
    //    @State private var loggedin = true
    @State var displayedView = AnyView(SplashScreenView())
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        ZStack {
            displayedView
        }
        .onAppear {
            delaySegue()
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            // first check in its the first time
            guard Helper.checkOnBoard() else {
                withAnimation{
                    displayedView = AnyView(OnBoardingView())
                }
                return
            }
            // second check if user is logedin or not
            guard Helper.userExist() else{
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
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


