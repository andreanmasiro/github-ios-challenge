//
//  UITableViewCell+CellHeight.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 04/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit

protocol UITableViewCellHelper: class {
  static var cellHeight: CGFloat { get }
}

extension UITableViewCellHelper where Self: UITableViewCell {
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
}

extension UITableViewCell: ReusableView, NibLoadableView, UITableViewCellHelper { }
