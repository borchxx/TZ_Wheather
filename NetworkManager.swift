//
//  NetworkManager.swift
//  TZ_Wheather
//
//  Created by admin on 4/1/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import CoreLocation

class NetworkManager {
    static var shared = NetworkManager()
    
    func loadWeather(lat: CLLocationDegrees, lon: CLLocationDegrees, completion: @escaping (WeatherModel?) -> Void) {
        
        let appID = "4f3520eee8473dba33c15bbde2610053"
        let lat = NSString(format:"%.2f", lat)
        let lon = NSString(format:"%.2f", lon)

        let urlString = "http://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(appID)&units=metric"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                error == nil,
                let data = data else {
                    completion(nil)
                    return
            }

            if let weatherModel = try? JSONDecoder().decode(WeatherModel.self, from: data) {
                print(weatherModel)
                completion(weatherModel)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
