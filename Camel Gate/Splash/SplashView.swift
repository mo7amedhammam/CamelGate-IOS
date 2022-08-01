//
//  SplashView.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 7/18/22.
//

import SwiftUI

struct SplashView: View {
//    @State private var loggedin = true
    var body: some View {
            ZStack {
                ZStack {}
                .frame( maxWidth: .infinity, maxHeight: .infinity)
                .background(Image("splashScreen").resizable())
                .ignoresSafeArea()
            }.onAppear {
                delaySegue()
        }
    }
    private func delaySegue() {
        // Delay of 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            // first check in its the first time
            guard Helper.checkOnBoard() else {
                navigationToBoard()
                return
            }
            // second check if user is logedin or not
            let authStatus = Helper.userExist()
                    guard authStatus else{
                        navigationToAuth()
                        return
                    }
            // finally
            navigationToHome()
        }
    }
    private func navigationToBoard(){
        let window = UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }
        window?.rootViewController = UIHostingController(rootView: OnBoardingView())
        //if loged in open tabBarView else open loginView
        window?.makeKeyAndVisible()
    }
    private func navigationToHome(){
        let window = UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }
        window?.rootViewController = UIHostingController(rootView: TabBarView())
        //if loged in open tabBarView else open loginView
        window?.makeKeyAndVisible()
    }
    private func navigationToAuth(){
        let window = UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }
        window?.rootViewController = UIHostingController(rootView: SignInView())
        //if loged in open tabBarView else open loginView
        window?.makeKeyAndVisible()
    }
}
    
struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
