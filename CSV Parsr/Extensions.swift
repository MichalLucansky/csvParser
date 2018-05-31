//
//  Extensions.swift
//  CSV Parsr
//
//  Created by Michal Lučanský on 27.5.18.
//  Copyright © 2018 MichalLucansky. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class var appOrange: UIColor {
          return UIColor(red: 238/255.0, green: 183/255.0, blue: 140/255.0, alpha: 1.0)
    }
    
    class var appMagenta: UIColor {
        return UIColor(red: 141/255.0, green: 133/255.0, blue: 160/255.0, alpha: 1.0)
    }
}


extension UIView {
    
    func setGradientColor(colorOne: UIColor, colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations =  [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
