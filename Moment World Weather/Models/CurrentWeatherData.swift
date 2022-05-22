//
//  CurrentWeatherData.swift
//  Moment World Weather
//
//  Created by Дмитрий Мартынов on 22.03.2022.
//

import Foundation

struct CurrentWeatherData: Codable {
    let name: String
    let main: Main
    let weather: [WeatherElement]
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
}

struct WeatherElement: Codable {
    let id: Int
}
