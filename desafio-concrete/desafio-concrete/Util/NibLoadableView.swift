//
//  NibLoadableView.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 04/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Foundation

protocol NibLoadableView: class {
  
  static var defaultNibName: String { get }
}
