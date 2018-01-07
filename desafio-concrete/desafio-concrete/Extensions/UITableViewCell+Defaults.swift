//
//  UITableViewCell+CellHeight.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 04/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit

extension AutoheightableView where Self: UITableViewCell {
  static var cellHeight: CGFloat {
    return 44.0
  }
}

extension ReusableView where Self: UITableViewCell {
  
  static var defaultReuseIdentifier: String {
    return className
  }
}

extension NibLoadableView where Self: UIView {
  
  static var defaultNibName: String {
    return className
  }
  
  static var viewFromDefaultNib: Self? {
    return Bundle.main.loadNibNamed(defaultNibName, owner: nil, options: nil)?.first as? Self
  }
}

extension UITableViewCell: ReusableView, NibLoadableView, AutoheightableView { }
