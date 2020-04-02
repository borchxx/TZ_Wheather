//
//  CollectionTableViewCell.swift
//  TZ_Wheather
//
//  Created by admin on 4/2/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
//    var wheather: ListWheatherModel?
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

//    func setWeather(_ wheather: ListWheatherModel){
//        self.wheather = wheather
//    }


}

extension CollectionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate{
    
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let wheather = wheather{
//            let timeWeather = wheather.list.count
//            return timeWeather
//        } else {
//            return 0
//        }
        return 10
         
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        return cell
    }

}
