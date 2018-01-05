//
//  UIView+CornerRadius.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 04/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit

extension UIView {
  
  @IBInspectable var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
    }
  }
  
  @IBInspectable var masksToBounds: Bool {
    get {
      return layer.masksToBounds
    }
    set {
      layer.masksToBounds = newValue
    }
  }
  
  @IBInspectable var makeRound: Bool {
    get {
      return layer.cornerRadius == bounds.height/2
    }
    set {
      layer.cornerRadius = newValue ? bounds.height/2 : 0
      masksToBounds = newValue
    }
  }
}
