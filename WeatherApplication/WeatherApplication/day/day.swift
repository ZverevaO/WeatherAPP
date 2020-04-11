//
//  day.swift
//  WeatherApplication
//
//  Created by Оксана Зверева on 11.04.2020.
//  Copyright © 2020 Oksana Zvereva. All rights reserved.
//

import UIKit

enum Day: Int {
    case monday
    case tuesday
    case wednesday
    case thuesday
    case firsday
    case saturday
    case sunday
    
    static let allDays: [Day] = [monday, tuesday, wednesday, thuesday, firsday, saturday, sunday]
    
    var title: String {
        switch  self {
        case .monday: return "ПН"
        case .tuesday: return "ВТ"
        case .wednesday: return "СР"
        case .thuesday: return "ЧТ"
        case .firsday: return "ПТ"
        case .saturday: return "СБ"
        case .sunday: return "ВС"
        }
    }
}
