//
//  WeatherCollectionView.swift
//  WeatherApplication
//
//  Created by Оксана Зверева on 14.06.2020.
//  Copyright © 2020 Oksana Zvereva. All rights reserved.
//

import UIKit
import AlamofireImage
import RealmSwift

class WeatherCollectionView: UICollectionViewController {
    
    var token: NotificationToken?
    var weathers: List<Weather>!
    let dateFormatter = DateFormatter()
    let weatherService = WeatherService()
    var cityName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        weatherService.loadWeatherData(city: cityName)
        pairTableAndRealm()
        
    }
    
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
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
        cell.icon.af.setImage(withURL: URL(string: weather.weatherIcon)!)
    print ("jhkjhkhkjhkhkh  hkjhkjhjhkjh lk h kjhkj hkjh kjhk jh kjhkjh kjhkjh")
        print (weather.weatherIcon)
        //cell.icon.image = UIImage(named: weather.weatherIcon)
        
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    
    
    func pairTableAndRealm() {
        guard let realm = try? Realm(), let city = realm.object(ofType: City.self, forPrimaryKey: cityName) else { return }
        
        weathers = city.weathers
        
        token = weathers.observe { [weak self] (changes: RealmCollectionChange) in
            guard let collectionView = self?.collectionView else { return }
            switch changes {
            case .initial:
                collectionView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                collectionView.performBatchUpdates({
                    collectionView.insertItems(at: insertions.map({ IndexPath(row: $0, section: 0) }))
                    collectionView.deleteItems(at: deletions.map({ IndexPath(row: $0, section: 0)}))
                    collectionView.reloadItems(at: modifications.map({ IndexPath(row: $0, section: 0) }))
                }, completion: nil)
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }
    
    
}


extension WeatherCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (collectionView.bounds.width - 41) / 3
        
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
