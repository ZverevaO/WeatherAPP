//
//  WeatherViewController.swift
//  WeatherApplication
//
//  Created by Оксана Зверева on 01.04.2020.
//  Copyright © 2020 Oksana Zvereva. All rights reserved.
//

import UIKit



class WeatherViewController: UIViewController {
 
    
    @IBOutlet weak var weekDayPicker: WeekDayPicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension  WeatherViewController : UICollectionViewDataSource
{
  func numberOfSections(in collectionView: UICollectionView) -> Int
  {
      return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
      
      cell.weather.text = "30 C"
      cell.time.text = "01.04.2020 18:00"
      
      return cell
  }
}

extension WeatherViewController : UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }

}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (collectionView.bounds.width - 41) / 3
        
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
}



