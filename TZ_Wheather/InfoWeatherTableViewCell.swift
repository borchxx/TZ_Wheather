//
//  InfoWeatherTableViewCell.swift
//  TZ_Wheather
//
//  Created by admin on 4/3/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class InfoWeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var feelLikesLabel: UILabel!
    @IBOutlet weak var rainfallLabel: UILabel!
    @IBOutlet weak var cloudinessLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setInfoCell(listWheatherModel: ListWheatherModel?){
        if let listWheatherModel = listWheatherModel {
            windSpeedLabel.text = String(Int(listWheatherModel.wind.speed))
            pressureLabel.text = String(Int(listWheatherModel.main.pressure))
            humidityLabel.text = String(Int(listWheatherModel.main.humidity))
            feelLikesLabel.text = String(Int(listWheatherModel.main.feels_like))
            cloudinessLabel.text = String(Int(listWheatherModel.clouds.all))
        }
    }
}
