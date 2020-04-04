//
//  WeatherModel.swift
//  TZ_Wheather
//
//  Created by admin on 4/1/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct WeatherModel: Codable {
    let list: [ListWheatherModel]
    let city: CityWheatherModel
}

struct ListWheatherModel: Codable {
    let main: MainWeather
    let weather: [InfoWheather]
    let dt_txt: String
    let sys: SysWeather
    let clouds: CloudsWeather
    let wind: WindWeather
}

struct WindWeather: Codable {
    let speed: Double
}

struct CloudsWeather: Codable {
    let all: Double
}

struct SysWeather: Codable {
    let pod: String
}

struct MainWeather: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let feels_like: Double
    let pressure: Double
    let humidity: Double
}

struct InfoWheather: Codable {
    let main: String
    let id: Double
    let description: String
}

struct CityWheatherModel: Codable {
    let name: String?
}
