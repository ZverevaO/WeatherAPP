//
//  WeatherCell.swift
//  WeatherApplication
//
//  Created by Оксана Зверева on 01.04.2020.
//  Copyright © 2020 Oksana Zvereva. All rights reserved.
//

import UIKit

class CircleView: UIView {
    override func layoutSubviews () {
       super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
    
}

class WeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var weather: UILabel!
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var containerView: UIView! 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 1.0
        containerView.layer.shadowRadius = 20
    }
    
    
    
}
