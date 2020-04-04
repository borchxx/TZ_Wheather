//
//  CollectionViewCell.swift
//  TZ_Wheather
//
//  Created by admin on 4/2/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var conditionWeatherImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    func setCollectionCell(listWheatherModel: ListWheatherModel?){
        if let listWheatherModel = listWheatherModel {
            var maxTemp = listWheatherModel.dt_txt
            let iconWeather = listWheatherModel.weather[0].id
            let temp = String(Int(listWheatherModel.main.temp))
            maxTemp = String(maxTemp.dropFirst(11))
            maxTemp = String(maxTemp.dropLast(3))
            timeLabel.text = maxTemp
            tempLabel.text = temp
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
    
    func configIconWeather(nameIcon: String){
        conditionWeatherImage.image = UIImage(named: nameIcon)
    }
}

