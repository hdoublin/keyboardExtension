//
//  AppDelegate.swift
//  kExtension
//
//  Created by Imran Rapiq on 2/3/20.
//  Copyright © 2020 Imran R. All rights reserved.
//

import UIKit

let storyboardMain = UIStoryboard(name: "Main", bundle: nil)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IAPHelper.startHelper()
        
        let addVC: ViewController = storyboardMain.instantiateViewController(withIdentifier: "IntroVC") as! ViewController
        self.window?.rootViewController = addVC
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

