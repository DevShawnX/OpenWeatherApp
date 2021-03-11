//
//  ViewController.swift
//  OpenWeatherApp
//
//  Created by Shawn on 3/10/21.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var lookupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        cityNameTextField.delegate = self
    }
    
    func setupUI() {
        // Add textfield bottomLine
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: cityNameTextField.frame.height - 2, width: cityNameTextField.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        cityNameTextField.layer.addSublayer(bottomLine)
        
        // Add button border
        lookupButton.layer.borderWidth = 1
        lookupButton.layer.borderColor = UIColor.black.cgColor
        lookupButton.layer.cornerRadius = 15
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Change navigationBar back button color
        if let backButtonName = cityNameTextField.text {
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: backButtonName, style: .plain, target: nil, action: nil)
            self.navigationController?.navigationBar.tintColor = UIColor.white
        }
    }
    
    @IBAction func helpButtonTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: AppConstants.Alert.tipsTitle, message: AppConstants.Alert.tipsMessage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: AppConstants.Alert.tipsActionTitle, style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func lookupButtonTapped() {
        let trimmedCityName = cityNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedCityName == "" {
            let alertController = UIAlertController(title: AppConstants.Alert.emptyNameTitle, message: AppConstants.Alert.emptyNameMessage, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: AppConstants.Alert.emptyNameActionTitle, style: .default, handler: nil)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true, completion: nil)
        }
        if let cityName = trimmedCityName?.replacingOccurrences(of: " ", with: "+") {
            let apiUrl = URL(string: AppConstants.URL.apiRootUrl + AppConstants.URL.cityParam + cityName + AppConstants.URL.apiKeyParam + AppConstants.URL.apiKey)
            guard let weatherListVC = storyboard?.instantiateViewController(identifier: AppConstants.StoryBoardID.weatherListViewController) as? WeatherListViewController else { return }
            weatherListVC.apiUrl = apiUrl
            weatherListVC.cityName = cityNameTextField.text
            self.navigationController?.pushViewController(weatherListVC, animated: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        lookupButtonTapped()
        return true
    }
}

