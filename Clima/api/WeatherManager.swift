//
//  WeatherManager.swift
//  Clima
//
//  Created by Abdullah Almasud on 31/10/21.
//

import Foundation

protocol WeatherManagerDelegate {
    func weatherDidUpdate(_ weatherManager: WeatherManager, weatherModel: WeatherModel)
    func weatherDidFail(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=3a8b54b6fe57554913e5e63ce4237be4&units=metric"
    var delegate : WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlStr: String) {
        // Create a URL
        if let url = URL(string: urlStr) {
            // Create a URL session
            let session = URLSession(configuration: .default)
            // Give the session a task
            let task = session.dataTask(with: url, completionHandler: {(data, response, error) in
                if error != nil {
                    delegate?.weatherDidFail(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = parseJson(safeData) {
                        delegate?.weatherDidUpdate(self, weatherModel: weather)
                    }
                }
            })
            // Start the task
            task.resume()
            
        }
    }
    
    func parseJson(_ weatherData: Data) -> WeatherModel? {
        do {
            let decodedData = try JSONDecoder().decode(
                WeatherResponse.self, from: weatherData
            )
            let name = decodedData.name
            let temp = decodedData.main.temp
            let code = decodedData.weather[0].id
            
            print(name)
            print("Temparature: \(temp)")
            print("Weather condition code: \(code)")
            
            let weather = WeatherModel(conditionCode: code, temparature: temp, cityName: name)
            
            return weather
            
        } catch {
            delegate?.weatherDidFail(error: error)
            
            return nil
        }
    }
    
}
