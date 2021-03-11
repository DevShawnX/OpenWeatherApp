//
//  WeatherViewModel.swift
//  OpenWeatherApp
//
//  Created by Shawn on 3/10/21.
//

import Foundation

class WeatherViewModel {
    
    func fetchWeatherAPIData(url: URL?, handler: @escaping ([DetailInfo]) -> ()) {
        guard let url = url else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            let response = (response as! HTTPURLResponse)
            print("***** HTTP Status Code: \(response.statusCode) *****")

            if let data = data
            {
                do {
                    let json = try JSONDecoder().decode(WeatherDataModel.self, from: data)
                    handler(json.list)
                } catch {
                    print(error.localizedDescription)
                }
            }
        } .resume()
    }
}

