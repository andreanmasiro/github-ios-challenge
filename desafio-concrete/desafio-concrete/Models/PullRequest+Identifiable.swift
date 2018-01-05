//
//  PullRequest+Identifiable.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 05/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import RxDataSources

extension PullRequest: IdentifiableType {
  
  var identity: Int {
    return id
  }
}
