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
  static var defaultNibName: String? { get }
}

extension UITableViewCellHelper {
  static var cellHeight: CGFloat {
    return 44.0
  }
  
  static var defaultNibName: String? {
    return nil
  }
}
extension UITableViewCell: UITableViewCellHelper {
}
