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
    let weather: InfoWheather
    let dt_txt: String
}

struct MainWeather: Codable {
    let temp: String
    let temp_max: String
    let temp_min: String
}

struct InfoWheather: Codable {
    let main: String
}

struct CityWheatherModel: Codable {
    let name: String?
}

