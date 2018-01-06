//
//  PullRequestHeaderModel.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 05/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Foundation

struct PullRequestHeaderModel {
  
  let openCount: Int
  let closedCount: Int
  
  init(pullRequests: [PullRequest]) {
    
    self.openCount = pullRequests.filter { $0.closedAt == nil }.count
    self.closedCount = pullRequests.count - self.openCount
  }
}
