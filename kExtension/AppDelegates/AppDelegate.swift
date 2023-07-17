//
//  AppDelegate.swift
//  kExtension
//
//  Created by Imran Rapiq on 2/3/20.
//  Copyright © 2020 Imran R. All rights reserved.
//

import UIKit
import Localize_Swift

let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
let screenSize: CGRect = UIScreen.main.bounds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if UserDefaults(suiteName: "group.wecodefonts")?.value(forKey: "isPurchased") == nil {
            UserDefaults(suiteName: "group.wecodefonts")?.set(0, forKey: "isPurchased")
            UserDefaults(suiteName: "group.wecodefonts")?.synchronize()
        }
        
        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().backgroundColor = .white
        UINavigationBar.appearance().tintColor = .black
        
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

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

        IAPHelper.checkSubscription(completion: { (status) in
            
        })
        IAPHelper.startHelper()
        
        let addVC: ViewController = storyboardMain.instantiateViewController(withIdentifier: "IntroVC") as! ViewController
        let navVC = UINavigationController(rootViewController: addVC)
        self.window?.rootViewController = navVC
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
//      print("Firebase registration token: \(fcmToken)")
//
//      let dataDict:[String: String] = ["token": fcmToken]
//      NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
//      // TODO: If necessary send token to application server.
//      // Note: This callback is fired at each app startup and whenever a new token is generated.
//    }
    
    private func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        // Messaging.messaging().apnsToken = deviceToken as Data
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        NotificationCenter.default.post(name: Notification.Name("didBecomeActive"), object: nil)
    }
    
    private func application(application: UIApplication,openURL url: NSURL,sourceApplication sourceApplication: String?,annotation: AnyObject?) -> Bool {
        print(url.absoluteString)
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {

        if url.absoluteString.contains("purchase") {
            NotificationCenter.default.post(name: Notification.Name("popSubsNotif"), object: nil)
            return true
        }
        return false
    }
    
}

extension UIApplication {
    
    class func topViewController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        
        return viewController
    }
}

extension NotificationCenter {
    func setObserver(_ observer: AnyObject, selector: Selector, name: NSNotification.Name, object: AnyObject?) {
        NotificationCenter.default.removeObserver(observer, name: name, object: object)
        NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: object)
    }
}
