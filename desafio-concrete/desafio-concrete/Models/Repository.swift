//
//  Repository.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 04/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Foundation

struct Repository: Codable {
  
  var id: Int
  var name: String
  var description: String
  var branchCount: Int
  var stargazersCount: Int
  var owner: User
  
  init(id: Int,
       name: String,
       description: String,
       branchCount: Int,
       stargazersCount: Int,
       owner: User) {
    
    self.id = id
    self.name = name
    self.description = description
    self.branchCount = branchCount
    self.stargazersCount = stargazersCount
    self.owner = owner
  }
}

extension Repository: Equatable {
  static func ==(lhs: Repository, rhs: Repository) -> Bool {
    return lhs.id == rhs.id
  }
}
