//
//  LoginManager.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 8/6/22.
//

import Foundation


struct LoginManger {

    static let key = "user"

    static func saveUser(_ value: LoginModel!) {
      setUserLogedin()
      setUserToken(token: value.token ?? "")
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: key)
    }

    static func getUser() -> LoginModel? {
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            do {
                let userData = try PropertyListDecoder().decode(LoginModel.self, from: data)
                return userData
            }catch{
                return nil
            }
        }else{return nil}
    }

    static func removeUser() {
        UserDefaults.standard.removeObject(forKey: "auth_token")
        UserDefaults.standard.setValue(false, forKey: "isLogin")
        UserDefaults.standard.removeObject(forKey: key)
    }
    static func logout() {
        
        removeUser()
        
        
        
        // MARK:- Developer should ADD
        // navigate to root AuthVC
        // should be like

        //let main = R.storyboard.auth.authRootViewController()!
        //BGNavigator.rootNavigation(newViewController: main)

    }
    static func setUserLogedin() {
        UserDefaults.standard.setValue(true, forKey: "isLogin")
    }
    static func setUserToken(token: String) {
        UserDefaults.standard.setValue(token, forKey: "auth_token")
    }
    static func checkUser() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLogin")
    }
}
