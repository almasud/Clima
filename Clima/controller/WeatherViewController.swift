//
//  ViewController.swift
//  Clima
//
//  Created by Abdullah Almasud on 28/10/21.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var imageViewWeather: UIImageView!
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var textFieldSearch: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Execute after loading the view.
        textFieldSearch.delegate = self
    }

    @IBAction func search(_ sender: UIButton) {
        textFieldSearch.endEditing(true)
        print(textFieldSearch.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldSearch.endEditing(true)
        print(textFieldSearch.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textFieldSearch.text != "" {
            return true
        } else {
            textFieldSearch.placeholder = "You must type someting!"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = textFieldSearch.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        textFieldSearch.text = ""
        textFieldSearch.placeholder = "Search"
    }
}

