//
//  Repository.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 04/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Foundation

struct Repository: Codable {
  
  let id: Int
  let name: String
  let description: String
  let forksCount: Int
  let stargazersCount: Int
  let owner: User
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case description
    case forksCount = "forks_count"
    case stargazersCount = "stargazers_count"
    case owner
  }
}

extension Repository: Equatable {
  static func ==(lhs: Repository, rhs: Repository) -> Bool {
    return lhs.id == rhs.id
  }
}
