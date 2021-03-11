//
//  WeatherListTableViewCell.swift
//  OpenWeatherApp
//
//  Created by Shawn on 3/10/21.
//

import UIKit

class WeatherListTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherLable: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
