//
//  WeatherService.swift
//  WeatherApplication
//
//  Created by Оксана Зверева on 14.06.2020.
//  Copyright © 2020 Oksana Zvereva. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift


class WeatherService {
    // базовый URL сервиса
    let baseUrl = "http://api.openweathermap.org"
    // ключ для доступа к сервису
    let apiKey = "92cabe9523da26194b02974bfcd50b7e" //3891a9817f229f1a86cb162f5d78b9d7"
    
    func loadWeatherData(city: String ){
        
        // путь для получения погоды за 5 дней
        let path = "/data/2.5/forecast"
        // параметры, город, единицы измерения градусы, ключ для доступа к сервису
        let parameters: Parameters = [
            "q": city,
            "units": "metric",
            "appid": apiKey
        ]
        
        // составляем url из базового адреса сервиса и конкретного пути к ресурсу
        let url = baseUrl+path
        
        // делаем запрос
        AF.request(url, method: .get, parameters: parameters).responseData { repsonse in
            guard let data = repsonse.value else { return }
            let weather = try! JSONDecoder().decode(WeatherResponse.self, from: data).list
            weather.forEach { $0.city = city }
            self.saveWeatherData(weather, city: city)
        
        }
        
    }
    
    func saveWeatherData(_ weathers: [Weather], city: String) {
    // обработка исключений при работе с хранилищем
            do {
    // получаем доступ к хранилищу
                let realm = try Realm()
    // получаем город
                guard let city = realm.object(ofType: City.self, forPrimaryKey: city) else { return }
    // все старые погодные данные для текущего города
                let oldWeathers = city.weathers
    // начинаем изменять хранилище
                realm.beginWrite()
    // удаляем старые данные
                realm.delete(oldWeathers)
    // кладем все объекты класса погоды в хранилище
                city.weathers.append(objectsIn: weathers)
    // завершаем изменение хранилища
                try realm.commitWrite()
            } catch {
    // если произошла ошибка, выводим ее в консоль
                print(error)
            }
        }



    
}

