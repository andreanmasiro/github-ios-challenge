//
//  UITableView+Helper.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 04/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit

extension UITableView {
  
  func registerCell(type: UITableView.Type, identifier: String, customNibName: String? = nil) {
    
    guard let nibName = customNibName ?? type
      .value(forKey: "defaultNibName") as? String else {
      return
    }
    
    let nib = UINib(nibName: nibName, bundle: nil)
    self.register(nib, forCellReuseIdentifier: identifier)
  }
}
