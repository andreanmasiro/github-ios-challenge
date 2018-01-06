//
//  PullRequest.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 05/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Foundation

struct PullRequest: Codable {
  
  let id: Int
  let title: String
  let body: String
  let closedAt: Date?
  let author: User
  let htmlURL: URL
  
  enum CodingKeys: String, CodingKey {
    
    case id
    case title
    case body
    case closedAt = "closed_at"
    case author = "user"
    case htmlURL = "html_url"
  }
  
  public init(from decoder: Decoder) throws {
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    self.id = try container.decode(Int.self, forKey: .id)
    self.title = try container.decode(String.self, forKey: .title)
    self.body = try container.decode(String?.self, forKey: .body) ?? ""
    self.closedAt = try container.decode(Date?.self, forKey: .closedAt)
    self.author = try container.decode(User.self, forKey: .author)
    self.htmlURL = try container.decode(URL.self, forKey: .htmlURL)
  }
}

extension PullRequest: Equatable {
  
  static func ==(lhs: PullRequest, rhs: PullRequest) -> Bool {
    return lhs.id == rhs.id
  }
}
