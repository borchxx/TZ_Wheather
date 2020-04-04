//
//  CollectionTableViewCell.swift
//  TZ_Wheather
//
//  Created by admin on 4/2/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    var wheather: WeatherModel?
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setWeather(_ wheather: WeatherModel){
        self.wheather = wheather
        let weatherBackground = wheather.list[0].sys.pod
        switch weatherBackground {
        case "n":
            collectionView.backgroundColor = UIColor(red: 41/256, green: 56/256, blue: 100/256, alpha: 1.00)
        case "d":
            collectionView.backgroundColor = UIColor(red: 100/256, green: 176/256, blue: 205/256, alpha: 1.00)
        default:
            collectionView.backgroundColor = UIColor(red: 100/256, green: 176/256, blue: 205/256, alpha: 1.00)
        }
    }
}

extension CollectionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if wheather != nil{
            return 8
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let weekTemp = wheather?.list[indexPath.row]
        cell.setCollectionCell(listWheatherModel: weekTemp)
        return cell
    }
}
