//
//  Network Manager.swift
//  Moment World Weather
//
//  Created by Дмитрий Мартынов on 22.03.2022.
//

import Foundation
import CoreLocation

protocol NetworkWeatherManagerDelegate: AnyObject {
    func updateInterface (_: NetworkWeatherManager, with currentWeather: CurrentWeather)
}

struct NetworkWeatherManager {
    weak var delegate: NetworkWeatherManagerDelegate?
    
    enum RequestType {
        case cityName(city: String)
        case coorinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    
    func fetchCurrentWeather(forRequestType requestType: RequestType) {
        var urlString = ""
        switch requestType {
        case .cityName(let city):
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        case .coorinate(let latitude, let longitude):
            urlString =  "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        }
        performRequest(withURLString: urlString)
    }
    
    
    fileprivate func performRequest(withURLString urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let currentWeather = parseJSON(withData: data) {
                    self.delegate?.updateInterface(self, with: currentWeather)
                }
            }
        }
        task.resume()
    }
    
    
    fileprivate func parseJSON(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else {
                return nil
            }
            return currentWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
