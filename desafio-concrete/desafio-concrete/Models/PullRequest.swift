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
  let description: String
  let open: Bool
  let author: User
}

extension PullRequest: Equatable {
  
  static func ==(lhs: PullRequest, rhs: PullRequest) -> Bool {
    return lhs.id == rhs.id
  }
}
