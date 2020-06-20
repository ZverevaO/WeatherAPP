//
//  WeatherViewController.swift
//  WeatherApplication
//
//  Created by Оксана Зверева on 01.04.2020.
//  Copyright © 2020 Oksana Zvereva. All rights reserved.
//

import UIKit




class WeatherViewController: UICollectionViewController {
    
    var weathers = [Weather]()
    let dateFormatter = DateFormatter()
    let weatherService = WeatherService()

 
    
    @IBOutlet weak var weekDayPicker: WeekDayPicker!
    
    
    override func viewDidLoad() {
        
        
        weatherService.loadWeatherData(city: "Moscow") {
        
        super.viewDidLoad()
        
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weathers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        
        let weather = weathers[indexPath.row]
        cell.weather.text = "\(weather.temp) C"
        dateFormatter.dateFormat = "dd.MM.yyyy HH.mm"
        let date = Date(timeIntervalSince1970: weather.date)
        let stringDate = dateFormatter.string(from: date)
        cell.time.text = stringDate
        
        //cell.icon.image = UIImage(named: weather.weatherIcon)
        
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
        
        func loadData() {
                do {
                    let realm = try Realm()
                    
                    let weathers = realm.objects(Weather.self).filter("city == %@", "Moscow")
                    
                    self.weathers = Array(weathers)
                    
                } catch {
        // если произошла ошибка, выводим ее в консоль
                    print(error)
                }
            }

}



extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (collectionView.bounds.width - 41) / 3
        
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
}



