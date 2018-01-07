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

  static var fake: Repository {
    return Repository()
  }
  
  private init() {
    self.id = 0
    self.name = ""
    self.description = ""
    self.forksCount = 0
    self.stargazersCount = 0
    self.owner = .fake
    self.pullsURL = fakeURL
  }
}

extension PullRequest {
  
  static var fake: PullRequest {
    return PullRequest()
  }
  
  private init() {
    
    self.id = 0
    self.title = ""
    self.body = ""
    self.createdAt = Date()
    self.closedAt = nil
    self.author = .fake
    self.htmlURL = fakeURL
  }
}
