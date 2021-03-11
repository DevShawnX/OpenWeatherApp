//
//  WeatherListViewController.swift
//  OpenWeatherApp
//
//  Created by Shawn on 3/10/21.
//

import UIKit

class WeatherListViewController: UITableViewController {

    var weatherDataSource = [DetailInfo]()
    let viewModel = WeatherViewModel()
    var apiUrl: URL?
    var cityName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeatherListData()
        setupUI()
    }
    
    func setupUI() {
        self.navigationController?.navigationBar.isHidden = false
        if let backButtonName = cityName {
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: backButtonName, style: .plain, target: nil, action: nil)
        }
    }

    func fetchWeatherListData() {
        viewModel.fetchWeatherAPIData(url: apiUrl) {
            returnData in
            self.weatherDataSource = returnData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if weatherDataSource.count == 0 {
            tableView.setWarningView(message: AppConstants.Alert.emptyWeatherMessage)
        } else {
            tableView.restoreView()
        }
        
        return weatherDataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.CellId.weatherListCellId, for: indexPath) as! WeatherListTableViewCell
        
        let data = weatherDataSource[indexPath.row]
        cell.weatherLable.text = data.weather[0].main
        let fahrenheitTemp = Int((data.main.temp - 273.15) * 9/5 + 32)
        cell.temperatureLabel.text = "Temp: " + String(fahrenheitTemp) + "°F"
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy hh:mm a"

        if let date = dateFormatterGet.date(from: data.date) {
            let formattedDateString = dateFormatterPrint.string(from: date)
            cell.dateLabel.text = formattedDateString
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let weatherDetailVC = storyboard?.instantiateViewController(identifier: AppConstants.StoryBoardID.weatherDetailViewController) as? WeatherDetailViewController else { return }
        let data = weatherDataSource[indexPath.row]
        weatherDetailVC.weatherIconCode = data.weather[0].icon
        weatherDetailVC.temperature = Int((data.main.temp - 273.15) * 9/5 + 32)
        weatherDetailVC.feelsLikeTemperature = Int((data.main.feelsLikeTemp - 273.15) * 9/5 + 32)
        weatherDetailVC.weather = data.weather[0].main
        weatherDetailVC.weatherDescription = data.weather[0].description
        self.navigationController?.pushViewController(weatherDetailVC, animated: true)
    }
}

extension UITableView {
    func setWarningView(message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textColor = UIColor.black
        messageLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        emptyView.addSubview(messageLabel)
        messageLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restoreView() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
