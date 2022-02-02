//
//  WeatherManager.swift
//  Clima
//
//  Created by Abdullah Almasud on 31/10/21.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=3a8b54b6fe57554913e5e63ce4237be4&units=metric"
    
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlStr: urlString)
    }
    
    func performRequest(urlStr: String) {
        // Create a URL
        if let url = URL(string: urlStr) {
            // Create a URL session
            let session = URLSession(configuration: .default)
            
            // Give the session a tast
            let task = session.dataTask(with: url, completionHandler: handlerT(data:urlResponse:error:))
            // Start the task
            task.resume()
            
        }
    }
    
    func handlerT(data: Data?, urlResponse: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        
        if let safeData = data {
            let dataStr = String(data: safeData, encoding: .utf8)
            print(dataStr)
        }
    }
}
