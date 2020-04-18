//
//  MyCitiesCell.swift
//  WeatherApplication
//
//  Created by Оксана Зверева on 31.03.2020.
//  Copyright © 2020 Oksana Zvereva. All rights reserved.
//

import UIKit

class MyCitiesCell: UITableViewCell {

    @IBOutlet weak var myCityName: UILabel! {
        didSet {
            self.myCityName.textColor = UIColor.white
        }
        
    }
    
    @IBOutlet weak var MyCityView: CircleShadowImage!
    
    let gradient = CAGradientLayer ()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.insertSublayer(gradient, at: 0)
        gradient.colors = [
            UIColor(red:0.00, green:0.30, blue:0.81, alpha:1.00).cgColor,
            UIColor(red:0.07, green:0.45, blue:0.87, alpha:1.00).cgColor
//            UIColor(red:0.77, green:0.87, blue:0.96, alpha:1.00).cgColor
//            UIColor.blue.withAlphaComponent(0.5).cgColor
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
