//
//  UITableView+Helper.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 04/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit

extension UITableView {
  
  func registerNib<T: UITableViewCell & UITableViewCellHelper>(_: T.Type, customIdentifier: String? = nil, customNibName: String? = nil) {
    
    let nibName = customNibName ?? T.defaultNibName
    let identifier = customIdentifier ?? T.defaultReuseIdentifier
    
    let nib = UINib(nibName: nibName, bundle: nil)
    self.register(nib, forCellReuseIdentifier: identifier)
  }
  
  func dequeueReusableCellWithDefaultIdentifier<T: UITableViewCell>(_: T.Type) -> T? {
    
    return dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier) as? T
  }
  
  func dequeueReusableCellWithDefaultIdentifier<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T? {
    
    return dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T
  }
}
