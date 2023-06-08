//
//  Resources.swift
//  PomodoroApp
//
//  Created by Nursat Sakyshev on 11.05.2023.
//

import UIKit

enum Resources {
    enum Colors {
        static var active = UIColor.black
        static var inActive = UIColor.white
        static var separator = UIColor.gray
    }
    
    enum Strings {
        enum TabBar {
            static var catalog = "Catalog"
            static var cart = "Cart"
            static var profile = "Profile"
        }
    }
    
    enum Images {
        enum TabBar {
            static var catalog = UIImage(systemName: "house.fill")
            static var cart = UIImage(systemName: "cart.fill")
            static var profile = UIImage(systemName: "person.circle.fill")
        }
    }
}
