//
//  AllCitiesCell.swift
//  WeatherApplication
//
//  Created by Оксана Зверева on 31.03.2020.
//  Copyright © 2020 Oksana Zvereva. All rights reserved.
//

import UIKit

class AllCitiesCell: UITableViewCell {

    @IBOutlet weak var cityName: UILabel! {
        didSet {
                   self.cityName.textColor = UIColor.white
               }
    }
    
    @IBOutlet weak var CityView: CircleShadowImage!
    
      let gradient = CAGradientLayer ()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.insertSublayer(gradient, at: 0)
               gradient.colors = [
                   UIColor.blue.cgColor,
                   UIColor.blue.withAlphaComponent(0.5).cgColor
               ]
               gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
               gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
          
          gradient.frame = contentView.bounds
      }

}
