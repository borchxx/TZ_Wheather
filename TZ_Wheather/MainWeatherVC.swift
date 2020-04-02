//
//  ViewController.swift
//  TZ_Wheather
//
//  Created by admin on 4/1/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import CoreLocation

class MainWeatherVC: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var temp: UILabel!
    
    let locationManager: CLLocationManager = CLLocationManager()
    var wheather: WeatherModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configLocation()
        scrollView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        let scroll = scrollView.contentInset.bottom
        print(scroll)
    }
}


extension MainWeatherVC: CLLocationManagerDelegate{
     func configLocation(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last
        let сoordinates =  CLLocationCoordinate2DMake((currentLocation?.coordinate.latitude)!, (currentLocation?.coordinate.longitude)!)
        let lat = сoordinates.latitude
        let lon = сoordinates.longitude
//        print(сoordinates)
        
       NetworkManager.shared.loadWeather(lat: lat, lon: lon, completion: { weatherModel in
            DispatchQueue.main.async {
                if let weatherModel = weatherModel {
                    let tepmInt = Int(weatherModel.list[0].main.temp)
                     let text = "\(tepmInt)°"
                     self.temp.text = text
                     self.wheather = weatherModel
                     let cityName = weatherModel.city.name
                     print("ETO SITY NAME  \(cityName)")
                     self.cityNameLabel.text = weatherModel.city.name
                 }
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension MainWeatherVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionTableViewCell") as! CollectionTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
          let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionTableViewCell") as! CollectionTableViewCell
//        if let wheather = wheather{
//            cell.setWeather(wheather)
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    
    
    
    
}
