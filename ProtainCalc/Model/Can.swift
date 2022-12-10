//
//  Can.swift
//  ProtainCalc
//
//  Created by Cheng Liang(Louis) on 2022/11/22.
//

import Foundation

enum Meat: String {
    case Chicken = "鸡肉"
    case Duck = "鸭肉"
    case Beef = "牛肉"
    case Fish = "鱼肉"
    case Rabbit = "兔肉"
    case Deer = "鹿肉"
}

struct Can: Identifiable {
    var id = UUID()
    var brand: String
    var country: String
    var meat: Meat
    var weight: Int
    var grossProtain: Double
    var grossFat: Double
    var water: Double
}
