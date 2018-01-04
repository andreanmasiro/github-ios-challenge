//
//  Repository+Identifiable.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 04/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import RxDataSources

extension Repository: IdentifiableType {
  
  var identity: String {
    return name
  }
}
