//
//  AppDelegate.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 05.06.2023.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        FirebaseApp.configure()
        window?.makeKeyAndVisible()
        UINavigationBar.appearance().tintColor = .black
//        setupOrders()
//        window?.rootViewController = UINavigationController(rootViewController: CatalogViewController())
//        window?.rootViewController = UINavigationController(rootViewController: CartViewController())
//        window?.rootViewController = UINavigationController(rootViewController: ProfileViewController())
//        window?.rootViewController = UINavigationController(rootViewController: ImagesViewController())
//        window?.rootViewController = UINavigationController(rootViewController: HistoryViewController())
//        window?.rootViewController = UINavigationController(rootViewController: his)
//        let tabVC = TabBarController()
//        window?.rootViewController = tabVC
//        window?.rootViewController = UINavigationController(rootViewController: SizeViewController())
//        window?.rootViewController = UINavigationController(rootViewController: AccountViewController())
//        window?.rootViewController = UINavigationController(rootViewController: ScrolController())
        
        //        window?.rootViewController = ViewController()
//                window?.rootViewController = UINavigationController(rootViewController: PageViewController())
//                window?.rootViewController = UINavigationController(rootViewController: WelcomeViewController())

        let isOnboardingSeen = UserDefaults.standard.bool(forKey: "isOnboardingSeen")
        print(isOnboardingSeen)
        if isOnboardingSeen {
            print("seen")
            if let user = FirebaseAuth.Auth.auth().currentUser{
                window?.rootViewController = TabBarController()
            }
            else {
                window?.rootViewController = UINavigationController(rootViewController: WelcomeViewController())
            }
        }
        else {
            window?.rootViewController = UINavigationController(rootViewController: PageViewController())
        }
//        window?.rootViewController = AuthViewController()
        return true
    }
    
}

