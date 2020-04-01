//
//  MyCitiesCell.swift
//  WeatherApplication
//
//  Created by Оксана Зверева on 31.03.2020.
//  Copyright © 2020 Oksana Zvereva. All rights reserved.
//

import UIKit

class MyCitiesCell: UITableViewCell {

    @IBOutlet weak var myCityName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
