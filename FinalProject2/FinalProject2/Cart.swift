//
//  Cart.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 07.06.2023.
//

import Foundation

var orders: [String: Int] = [:]

func setupOrders() {
    for sneaker in sneakers {
        orders["\(sneaker.name) \(sneaker.description)"] = 0
    }
    orders["\(sneakers[1].name) \(sneakers[1].description)"] = 3
}
