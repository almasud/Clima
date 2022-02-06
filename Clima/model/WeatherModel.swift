//
//  Weather.swift
//  Clima
//
//  Created by Abdullah Almasud on 6/2/22.
//

import Foundation

struct WeatherModel {
    let conditionCode : Int
    let temparature: Double
    let cityName: String
    
    var temparatureString : String {
        return String(format: "%.1f", temparature)
    }
    
    var conditionIconName : String {
        switch(conditionCode) {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
}
