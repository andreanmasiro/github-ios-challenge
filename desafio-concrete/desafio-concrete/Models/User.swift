//
//  User.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 04/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Foundation

struct User: Codable {
  
  var username: String
  var fullName: String
  var avatarPath: String
  
  init(username: String,
       fullName: String,
       avatarPath: String) {
    
    self.username = username
    self.fullName = fullName
    self.avatarPath = avatarPath
  }
}
