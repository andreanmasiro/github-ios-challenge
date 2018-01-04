//
//  UITableView+Helper.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 04/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit

extension UITableView {
  
  func registerNib(cellClass: UITableViewCell.Type, customIdentifier: String? = nil, customNibName: String? = nil) {
    
    guard let nibName = customNibName ?? cellClass
      .value(forKey: "defaultNibName") as? String,
      let identifier = customIdentifier ?? cellClass
        .value(forKey: "defaultIdentifier") as? String else {
      return
    }
    
    let nib = UINib(nibName: nibName, bundle: nil)
    self.register(nib, forCellReuseIdentifier: identifier)
  }
  
  func dequeueReusableCellWithDefaultIdentifier<T: UITableViewCell>(cellClass: T.Type) -> T? {
    
    guard let identifier = cellClass
      .value(forKey: "defaultIdentifier") as? String else {
        return nil
    }
    return dequeueReusableCell(withIdentifier: identifier) as? T
  }
  
  func dequeueReusableCellWithDefaultIdentifier<T: UITableViewCell>(cellClass: T.Type, for indexPath: IndexPath) -> T? {
    
    guard let identifier = cellClass
      .value(forKey: "defaultIdentifier") as? String else {
      return nil
    }
    return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T
  }
}
