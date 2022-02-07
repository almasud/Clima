//
//  ViewController.swift
//  Clima
//
//  Created by Abdullah Almasud on 28/10/21.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var imageViewWeather: UIImageView!
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var textFieldSearch: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Execute after loading the view
        textFieldSearch.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
        
        // Get permission for location
        locationManager.requestWhenInUseAuthorization()
        // Request for the location
        locationManager.requestLocation()
    }
    
    @IBAction func onClickLocation(_ sender: UIButton) {
        // Request for the location
        locationManager.requestLocation()
    }
}

// MARK: - UITextFieldDelegate
extension WeatherViewController : UITextFieldDelegate {
    
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

//MARK: - WeatherManagerDelegate
extension WeatherViewController : WeatherManagerDelegate {
    
    func weatherDidUpdate(_ weatherManager: WeatherManager, weatherModel: WeatherModel) {
        DispatchQueue.main.async {
            self.imageViewWeather.image = UIImage(systemName: weatherModel.conditionIconName)
            self.labelTemperature.text = weatherModel.temparatureString
            self.labelCity.text = weatherModel.cityName
        }
    }
    
    func weatherDidFail(error: Error) {
        print("weatherDidFail -> Error: \(error)")
    }
    
}

//MARK: - CLLocationManagerDelegate
extension WeatherViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            // Stop updating location once it got
            locationManager.stopUpdatingLocation()
            
            let lan = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lan, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
