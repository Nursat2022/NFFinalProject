//
//  AppDelegate.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 05.06.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
        UINavigationBar.appearance().tintColor = .black

        let isOnboardingSeen = UserDefaults.standard.bool(forKey: "isOnboardingSeen")
        //        window?.rootViewController = ViewController()
        //        window?.rootViewController = UINavigationController(rootViewController: PageViewController())
//                window?.rootViewController = UINavigationController(rootViewController: WelcomeViewController())
        if isOnboardingSeen {
            window?.rootViewController = UINavigationController(rootViewController: WelcomeViewController())
        }
        else {
            window?.rootViewController = UINavigationController(rootViewController: PageViewController())
        }
//        window?.rootViewController = RegistrationViewController()
        
        return true
    }
    
}

