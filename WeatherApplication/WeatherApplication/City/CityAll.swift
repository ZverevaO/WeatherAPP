//
//  CityAll.swift
//  WeatherApplication
//
//  Created by Оксана Зверева on 11.04.2020.
//  Copyright © 2020 Oksana Zvereva. All rights reserved.
//

class CitiesAll: Comparable {
    var name: String
    var icon: String
    
    init(name: String, icon: String) {
        self.name = name
        self.icon = icon
    }
    
    static func == (lhs: CitiesAll, rhs: CitiesAll) -> Bool {
           return lhs.name == rhs.name
       }
       
       static func < (lhs: CitiesAll, rhs: CitiesAll) -> Bool {
           return lhs.name < rhs.name
       }
}
