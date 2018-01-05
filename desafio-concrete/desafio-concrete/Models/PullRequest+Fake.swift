//
//  PullRequest+Fake.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 05/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Foundation

extension PullRequest {
  
  static func fake(author: User) -> PullRequest {
    
    return PullRequest(id: 1,
                       title: "Some AMAZING changes",
                       description: "I request for you to please accept my pull request for it contains AMAZING changes",
                       open: true,
                       author: author)
  }
}
