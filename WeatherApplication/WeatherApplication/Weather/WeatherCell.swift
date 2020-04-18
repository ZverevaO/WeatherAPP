//
//  WeatherCell.swift
//  WeatherApplication
//
//  Created by Оксана Зверева on 01.04.2020.
//  Copyright © 2020 Oksana Zvereva. All rights reserved.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var weather: UILabel!
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var containerView: UIView! {
      
        didSet {
               self.containerView.clipsToBounds = true
           }

    }
    
    @IBOutlet weak var shadowView: UIView! {
      
        didSet {
            self.shadowView.layer.shadowOffset = .zero
            self.shadowView.layer.shadowOpacity = 0.75
            self.shadowView.layer.shadowRadius = 6
            self.shadowView.backgroundColor = .clear
        }

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.shadowView.layer.shadowPath = UIBezierPath(ovalIn: self.shadowView.bounds).cgPath
        self.containerView.layer.cornerRadius = self.containerView.frame.width / 2
    }
    
}
