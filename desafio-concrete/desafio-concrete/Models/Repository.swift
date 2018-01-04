//
//  Repository.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 04/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Foundation

struct Repository: Codable {
  
  var name: String
  var description: String
  var branchCount: Int
  var stargazersCount: Int
  var owner: User
}
