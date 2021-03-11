//
//  WeatherDataModel.swift
//  OpenWeatherApp
//
//  Created by Shawn on 3/10/21.
//

import Foundation

struct WeatherDataModel: Decodable {
    var list: [DetailInfo]
}

struct DetailInfo: Decodable {
    enum CodingKeys: String, CodingKey {
        case main = "main"
        case weather = "weather"
        case date = "dt_txt"
    }
    var main: TemperatureInfo
    var weather: [WeatherInfo]
    var date: String
}

struct TemperatureInfo: Decodable {
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feelsLikeTemp = "feels_like"
    }
    var temp: Double
    var feelsLikeTemp: Double
}

struct WeatherInfo: Decodable {
    var main: String
    var description: String
    var icon: String
}


