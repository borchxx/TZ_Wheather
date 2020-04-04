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

    @IBOutlet weak var conditionWeatherLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var temp: UILabel!
    
    var defaultOffSet: CGPoint?
    let locationManager: CLLocationManager = CLLocationManager()
    private var weather: WeatherModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = UserDefaults.standard.value(forKey:"weather") as? Data {
            weather = try? PropertyListDecoder().decode(WeatherModel.self, from: data)
        }
        configLocation()
        self.tableView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
    }
}

//MARK: - Create and configurate LocationManager

extension MainWeatherVC: CLLocationManagerDelegate{
     func configLocation(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation() 
        }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        let currentLocation = locations.last
        let сoordinates =  CLLocationCoordinate2DMake((currentLocation?.coordinate.latitude)!, (currentLocation?.coordinate.longitude)!)
        let lat = сoordinates.latitude
        let lon = сoordinates.longitude
        
        NetworkManager.shared.loadNews(lat: lat, lon: lon) { result in
          switch result {
            case .success(let weatherModel):
                self.weather = weatherModel
                self.configurateCityAndСondition()
                self.saveAndUpdateData()
                self.tableView.reloadData()
            case .failure(_):
                if let data = UserDefaults.standard.value(forKey:"weather") as? Data {
                    self.weather = try? PropertyListDecoder().decode(WeatherModel.self, from: data)
                    self.configurateCityAndСondition()
                }
            }
        }
    }
    
    func configurateCityAndСondition(){
        if let weather = weather {
            let list = weather.list[0]
            let weatherBackground = list.sys.pod
            self.conditionWeatherLabel.text = list.weather[0].main
            self.cityNameLabel.text = weather.city.name
            let tepmInt = Int(list.main.temp)
            let text = "\(tepmInt)°"
            self.temp.text = text
            switch weatherBackground {
            case "n":
                view.backgroundColor = UIColor(red: 41/256, green: 56/256, blue: 100/256, alpha: 1.00)
            case "d":
                view.backgroundColor = UIColor(red: 100/256, green: 176/256, blue: 205/256, alpha: 1.00)
            default:
                view.backgroundColor = UIColor(red: 100/256, green: 176/256, blue: 205/256, alpha: 1.00)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func saveAndUpdateData(){
        if weather != nil {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(weather), forKey:"weather")
        }
    }
}

//MARK: - Create and configurate TableView

extension MainWeatherVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 6
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SuperCrutchTableViewCell") as! SuperCrutchTableViewCell
            if let weather = weather {
                let weekInfo = weather.list[indexPath.row]
                cell.setNowWeather(listWheatherModel: weekInfo)
                
            }
             return cell
        case 1:
            switch indexPath.row {
            case 0...4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "WeekTableViewCell") as! WeekTableViewCell
                if let weather = weather {
                    let arrrayWeather: [ListWheatherModel] = weather.list
                    let array = arrrayWeather.enumerated().compactMap { index, element in index % 8 != 0 ? nil : element }
                    cell.setWeekWeather(listWheatherModel: array[indexPath.row])
                }
                return cell
            case 5:
                let cell = tableView.dequeueReusableCell(withIdentifier: "InfoWeatherTableViewCell") as! InfoWeatherTableViewCell
                let weekInfo = weather?.list[indexPath.row]
                cell.setInfoCell(listWheatherModel: weekInfo)
                return cell
            default:
                  let cell = tableView.dequeueReusableCell(withIdentifier: "SuperCrutchTableViewCell") as! SuperCrutchTableViewCell
                  
                  return cell
            }
        default:
                return UITableViewCell.init()
            }
        }
            
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SuperCrutchHeaderTableViewCellTableViewCell") as! SuperCrutchHeaderTableViewCellTableViewCell
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionTableViewCell") as! CollectionTableViewCell
            if let weather = weather{
            cell.setWeather(weather)
        }
        return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionTableViewCell") as! CollectionTableViewCell
            if let weather = weather{
                cell.setWeather(weather)
            }
            return cell
        }
          
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 120
        case 1:
            return 100
        default:
            return 100
        }
    }
}

extension MainWeatherVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let alpha: CGFloat = tableView.contentOffset.y / -100
        temp.textColor = UIColor(white: 1, alpha: alpha)
        let alphaNotification: [String: CGFloat] = ["alpha": alpha]
        NotificationCenter.default.post(name: NSNotification.Name("alpha"), object: nil, userInfo: alphaNotification)
    }
}
