//
//  Cart.swift
//  FinalProject2
//
//  Created by Nursat Sakyshev on 07.06.2023.
//

import Foundation

//var orders: [Sneakers: Int] {
//    get {
//        if sneakers.count != 0 {
//            APIManager.shared.getPost(collection: "orders", docName: "nurs@gmail.com") { order in
//                orders[sneakersByImageName[order.keys.first!]!] = order.values.first
//            }
//
//        }
//        return [:]
//    }
//}

var orders: [Sneakers: Int] = [:]

//let sneakers = [Sneakers(imageName: "sneakers1", name: "Dolce & Gabbana", description: "Кеды с принтом граффити", price: 1251), Sneakers(imageName: "sneakers2", name: "Off-White", description: "Кроссовки Off-Court 3.0", price: 551), Sneakers(imageName: "sneakers3", name: "Jordan", description: "Кеды с принтом граффити", price: 1251), Sneakers(imageName: "sneakers4", name: "Jordan", description: "Кеды с принтом граффити", price: 1251), Sneakers(imageName: "sneakers5", name: "Balenciaga", description: "кроссовки Runner", price: 945), Sneakers(imageName: "sneakers6", name: "Lanvin", description: "кроссовки Curb на шнуровке", price: 700), Sneakers(imageName: "sneakers7", name: "Off-White", description: "кроссовки Odsy-1000", price: 900), Sneakers(imageName: "sneakers8", name: "Adidas YEEZY", description: "Кроссовки YEEZY 700 V3 Copper Fade", price: 255), Sneakers(imageName: "sneakers9", name: "Jordan", description: "кроссовки Jordan Max Aura 4", price: 543), Sneakers(imageName: "sneakers10", name: "Jordan", description: "кроссовки Air Jordan 1 Retro", price: 350), Sneakers(imageName: "sneakers11", name: "Off-White", description: "кроссовки с логотипом Arrows", price: 405), Sneakers(imageName: "sneakers12", name: "Maison Mihara Yasuhiro", description: "кроссовки с контрастной шнуровкой", price: 700)]
var sneakers: [Sneakers] = []
var shoeSize = 41.5

var numberOfOrders = 1

var data = ["username": "Nursat", "password": "hello"]

//var orderHistory = [orderData(number: 1, date: "24.12.2023", numberOfItems: 5, totalPrice: 1234), orderData(number: 2, date: "24.12.2023", numberOfItems: 3, totalPrice: 1234), orderData(number: 3, date: "24.12.2023", numberOfItems: 5, totalPrice: 1234), orderData(number: 4, date: "24.12.2023", numberOfItems: 5, totalPrice: 1234), orderData(number: 5, date: "24.12.2023", numberOfItems: 2, totalPrice: 3543)]



let orderDetail = [orderHistory[0]]

struct orderData {
    var number: Int
    var date: String
    var numberOfItems: Int
    var totalPrice: Int
    var products: [Sneakers: Int]
}

var orderHistory: [orderData] = []

var sneakersByImageName = [String: Sneakers]()

func setupOrders() {
//    for sneaker in sneakers {
//        orders["\(sneaker.name) \(sneaker.description)"] = 0
//    }
//    orders["\(sneakers[1].name) \(sneakers[1].description)"] = 3
//    orders[sneakers[1]] = 3
//    orders[sneakers[0]] = 6
}

