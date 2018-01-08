//
//  Models+Fake.swift
//  desafio-concreteTests
//
//  Created by André Marques da Silva Rodrigues on 07/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Foundation

@testable import desafio_concrete

fileprivate let fakeURL = URL(string: "www.url.com")!
extension User {
  
  static var fake: User {
    return User()
  }
  
  private init() {
    self.username = ""
    self.avatarURL = fakeURL
  }
}

extension Repository {
  
  static func fake(id: Int = 0) -> Repository {
    return self.init(id: id)
  }
  
  private init(id: Int) {
    self.id = id
    self.name = ""
    self.description = ""
    self.forksCount = 0
    self.stargazersCount = 0
    self.owner = .fake
    self.pullsURL = fakeURL
  }
}

extension PullRequest {
  
  static func fake(id: Int = 0) -> PullRequest {
    return self.init(id: id)
  }
  
  private init(id: Int) {
    
    self.id = id
    self.title = ""
    self.body = ""
    self.createdAt = Date()
    self.closedAt = nil
    self.author = .fake
    self.htmlURL = fakeURL
  }
}
