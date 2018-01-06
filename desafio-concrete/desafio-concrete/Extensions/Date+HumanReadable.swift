//
//  Date+HumanReadable.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 06/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Foundation

extension Date {
  
  var humanReadableDescription: String {
    
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"
    
    return formatter.string(from: self)
  }
}
