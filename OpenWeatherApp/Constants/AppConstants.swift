//
//  AppConstants.swift
//  OpenWeatherApp
//
//  Created by Shawn on 3/10/21.
//

import Foundation

enum AppConstants {
    enum URL {
        static let apiRootUrl = "https://api.openweathermap.org/data/2.5/forecast?"
        static let cityParam = "q="
        static let apiKeyParam = "&appid="
        static let apiKey = "65d00499677e59496ca2f318eb68c049"
        static let iconRootUrl = "https://openweathermap.org/img/wn/"
        static let iconExtension = "@2x.png"
    }
    
    enum StoryBoardID {
        static let weatherListViewController = "WeatherListViewController"
        static let weatherDetailViewController = "WeatherDetailViewController"
    }
    
    enum Alert {
        static let tipsTitle = "Tips"
        static let tipsMessage = "Please enter a city name in the text field below to look up weather. \n\n Make sure you type in the full name if the city name has a space in between(e.g. Los Angeles)."
        static let tipsActionTitle = "Got it"
        static let emptyNameTitle = "Heads Up!"
        static let emptyNameMessage = "Please enter a city name!"
        static let emptyNameActionTitle = "OK"
        static let emptyWeatherMessage = "Oops!\n\nNo weather data for your city\n\nPlease go back to check the city name"
    }
    
    enum CellId {
        static let weatherListCellId = "reuseIdentifier"
    }
}
