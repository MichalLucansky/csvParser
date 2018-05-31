//
//  CategoryCollectionViewCell.swift
//  CSV Parsr
//
//  Created by Michal Lučanský on 27.5.18.
//  Copyright © 2018 MichalLucansky. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bacgroundVIew: UIView!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    func setUpView(dataName:String){
        bacgroundVIew.setGradientColor(colorOne: .appMagenta, colorTwo: .appOrange)
        categoryLabel.text = dataName
    }
    
}
