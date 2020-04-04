//
//  WeekTableViewCell.swift
//  TZ_Wheather
//
//  Created by admin on 4/2/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class WeekTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var conditionWeatherImage: UIImageView!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configIconWeather(nameIcon: String){
        conditionWeatherImage.image = UIImage(named: nameIcon)
    }
    
    func weekdayName(dateString: String){
        
        let formatterISO = DateFormatter()
        formatterISO.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        if let dateISO = formatterISO.date(from: dateString){
            dayLabel.text = formatter.string(from: dateISO)
        }
    }

    func setWeekWeather(listWheatherModel: ListWheatherModel?){
        if let listWheatherModel = listWheatherModel{
            let dateISO = listWheatherModel.dt_txt
            weekdayName(dateString: dateISO)
            let iconWeather = listWheatherModel.weather[0].id
            let maxTemp = String(Int(listWheatherModel.main.temp_max))
            let minTemp = String(Int(listWheatherModel.main.temp_min))
            maxTempLabel.text = maxTemp
            minTempLabel.text = minTemp
            switch iconWeather {
                case 800:
                       configIconWeather(nameIcon: "clear")
                   case 801,802, 803, 804:
                       configIconWeather(nameIcon: "cloudy")
                   case 500:
                       configIconWeather(nameIcon: "rain")
                   case 600:
                       configIconWeather(nameIcon: "snow")
                   default:
                       configIconWeather(nameIcon: "cloudy")
            }
        }
    }
}
