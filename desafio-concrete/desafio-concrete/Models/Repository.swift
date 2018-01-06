//
//  Repository.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 04/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Foundation

enum RepositoryDecodingError: Error {
  case invalidPullsURL
}

struct Repository: Codable {
  
  let id: Int
  let name: String
  let description: String
  let forksCount: Int
  let stargazersCount: Int
  let owner: User
  let pullsURL: URL
  
  public init(from decoder: Decoder) throws {
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    self.id = try container.decode(Int.self, forKey: .id)
    self.name = try container.decode(String.self, forKey: .name)
    self.description = try container.decode(String?.self, forKey: .description) ?? ""
    self.forksCount = try container.decode(Int.self, forKey: .forksCount)
    self.stargazersCount = try container.decode(Int.self, forKey: .stargazersCount)
    self.owner = try container.decode(User.self, forKey: .owner)
    let pullsPath = try container.decode(String.self, forKey: .pullsURL).replacingOccurrences(of: "{/number}", with: "")
    
    guard let pullsURL = URL(string: pullsPath) else {
      throw RepositoryDecodingError.invalidPullsURL
    }
    
    self.pullsURL = pullsURL
  }
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case description
    case forksCount = "forks_count"
    case stargazersCount = "stargazers_count"
    case owner
    case pullsURL = "pulls_url"
  }
}

extension Repository: Equatable {
  static func ==(lhs: Repository, rhs: Repository) -> Bool {
    return lhs.id == rhs.id
  }
}
