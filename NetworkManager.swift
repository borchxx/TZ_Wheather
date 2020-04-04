//
//  NetworkManager.swift
//  TZ_Wheather
//
//  Created by admin on 4/1/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import CoreLocation


enum NetworkError: Error {
    case defauldError
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class NetworkManager {
    static let shared = NetworkManager()
    
    func performRequst(_ request: URLRequest, completion: @escaping (Result<Data?, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200,
                    error == nil else {
                        completion(Result.failure(NetworkError.defauldError))
                        return
                }
                completion(Result.success(data))
            }
        }
        task.resume()
    }
    
  func loadNews(lat: Double, lon: Double, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        let appID = "4f3520eee8473dba33c15bbde2610053"
        let urlString = "http://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(appID)&units=metric"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
            
        performRequst(request) { result in
            switch result {
            case .success(let data):
                if let data = data,
                    let weatherModel = try? JSONDecoder().decode(WeatherModel.self, from: data) {
                    completion(Result.success(weatherModel))
                } else {
                    completion(Result.failure(NetworkError.defauldError))
                }

            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
