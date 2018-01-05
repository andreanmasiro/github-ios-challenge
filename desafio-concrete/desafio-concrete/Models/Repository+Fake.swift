//
//  Repository+Fake.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 05/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Foundation

extension Repository {
  
  static func fake(owner: User) -> Repository {
    return Repository(id: 1,
               name: "R1",
               description: "Super repository from great andreanmasiro",
               branchCount: 3,
               stargazersCount: 29000,
               owner: owner)
  }
}
