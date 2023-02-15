//
//  Camel_GateApp.swift
//  Camel Gate
//
//  Created by Tawfik Sweedy✌️ on 7/17/22.
//

import SwiftUI
import Firebase
import FirebaseMessaging
import UserNotifications


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
                .environment(\.locale, .init(identifier: "en"))
//                .environment(\.locale, .init(identifier: "ar"))

        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    let gcmMessageIDKey = "gcm.Message_ID"

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

      //    MARK: ------ Notifications setup -------
      if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: {_, _ in })
      } else {
        let settings: UIUserNotificationSettings =
        UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        application.registerUserNotificationSettings(settings)
      }
      application.registerForRemoteNotifications()

      
//      UserDefaults.standard.set("EN", forKey: "AppleLanguage")

    return true
  }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
    }
    
    
    //    MARK: ------ Notifications Messaging -------
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
            if let messageID = userInfo[gcmMessageIDKey] {
                print("Message ID: \(messageID)")
            }
            print(userInfo)
        }

        func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                         fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
            if let messageID = userInfo[gcmMessageIDKey] {
                print("Message ID: \(messageID)")
            }
            print(userInfo)
            completionHandler(UIBackgroundFetchResult.newData)
        }
    
//    private func process(_ notification: UNNotification) {
//      // 1
//      let userInfo = notification.request.content.userInfo
//      // 2
//      UIApplication.shared.applicationIconBadgeNumber = 0
//      if let newsTitle = userInfo["newsTitle"] as? String,
//        let newsBody = userInfo["newsBody"] as? String {
//        let newsItem = NewsItem(title: newsTitle, body: newsBody, date: Date())
//        NewsModel.shared.add([newsItem])
//      }
//    }
    
}


extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(fcmToken ?? "")")

      let dataDict:[String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(name: .FirebaseTokenName, object: nil, userInfo: dataDict)
    }
}


@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    let userInfo = notification.request.content.userInfo
    print(userInfo)
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }
      completionHandler([[.banner, .sound]])
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
   // completionHandler()
      
      let userInfo = response.notification.request.content.userInfo
            if let messageID = userInfo[gcmMessageIDKey] {
                print("Message ID: \(messageID)")
            }
      
      // action here  ..,  if  you want to print object from firebase
      print(" infoooooooooooooooooo : \(userInfo)")
//              print(" titleeeeeeeeeeeeeeee : \(userInfo["title"] as! String)") // title or description or image

//      if userInfo[""] as? String == "" {
////          MARK: --- user action ----
////          if userInfo["red"] as! Int == 0 {
////                        let mainSB = UIStoryboard(name: "Main", bundle: nil)
////                        if let RootVc = mainSB.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
////                            RootVc.Revision_Id             = Int(userInfo["item_id"] as? String ?? "0")!
////                            RootVc.TypeFrom = "notification"
////                            UIWindow.key.rootViewController = RootVc
////                        }
////                    }
//      }
      
      completionHandler()
      
  }
}
extension Notification.Name {
    static let FirebaseTokenName = Notification.Name("FCMToken")
}




#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
                UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
#endif
