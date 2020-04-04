//
//  SuperCrutchTableViewCell.swift
//  TZ_Wheather
//
//  Created by admin on 4/3/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

enum DayOrNight{
    case day, night
}

class SuperCrutchTableViewCell: UITableViewCell {

    @IBOutlet weak var nightOrfDayLabel: UILabel!
    @IBOutlet weak var dayOfTheWeekLabel: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    let nc = NotificationCenter.default
    override func awakeFromNib() {
        super.awakeFromNib()
        nc.addObserver(self, selector: #selector(showSpinningWheel), name: NSNotification.Name(rawValue: "alpha"), object: nil)
    }
    
    @objc func showSpinningWheel(_ notification: NSNotification) {
     if let alpha = notification.userInfo?["alpha"] as? CGFloat {
        nightOrfDayLabel.textColor = UIColor(white: 1, alpha: alpha)
        dayOfTheWeekLabel.textColor = UIColor(white: 1, alpha: alpha)
        maxTemp.textColor = UIColor(white: 1, alpha: alpha)
        minTemp.textColor = UIColor(white: 1, alpha: alpha)
     }
    }
    
    func setNowWeather(listWheatherModel: ListWheatherModel?){
        if let listWheatherModel = listWheatherModel{
            
            let dayOrNight = listWheatherModel.sys.pod
            let date = listWheatherModel.dt_txt
            weekdayName(dateString: date)
            maxTemp.text = String(Int(listWheatherModel.main.temp_max))
            minTemp.text = String(Int(listWheatherModel.main.temp_min))
            switch dayOrNight {
            case "d":
                nightOrfDayLabel.text = "day"
            case "n":
                nightOrfDayLabel.text = "night"
            default:
                nightOrfDayLabel.text = "day"
            }
        }
    }
    
    func weekdayName(dateString: String){
        let formatterISO = DateFormatter()
        formatterISO.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        if let dateISO = formatterISO.date(from: dateString){
            dayOfTheWeekLabel.text = formatter.string(from: dateISO)
            }
    }
}
