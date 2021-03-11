//
//  WeatherDetailViewController.swift
//  OpenWeatherApp
//
//  Created by Shawn on 3/10/21.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    var weatherIconCode: String?
    var temperature: Int?
    var feelsLikeTemperature: Int?
    var weather: String?
    var weatherDescription: String?

    @IBOutlet weak var weatherIconImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayInfo()
    }
    
    func displayInfo() {
        if let icon = weatherIconCode, let temp = temperature, let feelsLikeTemp = feelsLikeTemperature, let weather = weather, let weatherDesc = weatherDescription {
            DispatchQueue.global(qos: .background).async {
                let url = URL(string: AppConstants.URL.iconRootUrl + icon + AppConstants.URL.iconExtension)
                do {
                    guard let url = url else { return }
                    let iconData = try Data(contentsOf: url)
                    let iconImage = UIImage(data: iconData)
                    DispatchQueue.main.async {
                        self.weatherIconImage.image = iconImage
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            temperatureLabel.text = String(temp) + "°F"
            feelsLikeTemperatureLabel.text = "Feels Like: " + String(feelsLikeTemp) + "°F"
            weatherLabel.text = weather
            weatherDescriptionLabel.text = weatherDesc
        }
    }
}
