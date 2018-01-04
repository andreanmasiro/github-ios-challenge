//
//  UIColor+RGB.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 04/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit.UIColor

extension UIColor {
  
  static func with(rgb: Int, alpha: CGFloat = 1.0) -> UIColor {
    
    let (r, g, b) = (
      CGFloat((rgb >> 16) & 0xFF)/255,
      CGFloat((rgb >> 8) & 0xFF)/255,
      CGFloat(rgb & 0xFF)/255
    )
    return UIColor(red: r, green: g, blue: b, alpha: alpha)
  }
}
