//
//  NSObject+ClassName.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 04/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Foundation

extension NSObject {
  
  static var className: String {
    return String(describing: self)
  }
}
