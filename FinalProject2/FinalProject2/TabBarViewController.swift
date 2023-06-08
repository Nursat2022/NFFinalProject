//
//  TabBarController.swift
//  PomodoroApp
//
//  Created by Nursat Sakyshev on 11.05.2023.
//

import UIKit

enum Tabs: Int {
    case catalog
    case cart
    case profile
}

final class TabBarController: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        tabBar.tintColor = Resources.Colors.active
        tabBar.barTintColor = Resources.Colors.inActive
        tabBar.layer.borderColor = Resources.Colors.separator.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
        
        let navVC1 = UINavigationController(rootViewController: CatalogViewController())
        let navVC2 = UINavigationController(rootViewController: CartViewController())
        let navVC3 = UINavigationController(rootViewController: ProfileViewController())
        
        navVC1.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.catalog, image: Resources.Images.TabBar.catalog, tag: Tabs.catalog.rawValue)
        navVC2.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.cart, image: Resources.Images.TabBar.cart, tag: Tabs.cart.rawValue)
        navVC3.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.profile, image: Resources.Images.TabBar.profile, tag: Tabs.profile.rawValue)
        
        setViewControllers([
            navVC1,
            navVC2,
            navVC3
        ], animated: true)
    }
}
