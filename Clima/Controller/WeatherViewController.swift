//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchTextField.delegate = self
        
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print("searchPressed called")
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print("textFieldShouldReturn called")
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing called")
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Don't leave it empty"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing called")
        var weatherUrl = ""
        if let city = searchTextField.text {
            weatherUrl = weatherManager.fetchWeather(cityName: city)
            if let url = URL(string: weatherUrl) {
                UIApplication.shared.open(url)
            }
        }
        
//        if UIApplication.shared.canOpenURL(url) {
//             UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        }
//        guard let urll = URL(string: "https://stackoverflow.com") else { return }
//        UIApplication.shared.open(urll)
//        if let url = URL(string: "https://www.google.com") {
//            UIApplication.shared.open(url)
//        }
//        
//        
//        UIApplication.shared.open(URL(string: url))

        searchTextField.text = ""
    }
    
    
    
    
}

