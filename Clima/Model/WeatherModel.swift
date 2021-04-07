//
//  WeatherModel.swift
//  Clima
//
//  Created by Baris Karalar on 7.04.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%0.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200..<300: //Thunderstorm
            return "cloud.bolt"
        case 300..<400: //Drizzle
            return "cloud.drizzle"
        case 500..<600: //Rain
            return "cloud.rain"
        case 600..<700: //Snow
            return "cloud.snow"
        case 700..<800: //Atmosphere
            return "tornado"
        case 800: //Clear
            return "sun.max"
        case 801...804: //Cloud
            return "sun.max"
        default:
            return "cloud"
        }
    }
    
}
