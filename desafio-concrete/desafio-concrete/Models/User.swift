//
//  User.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 04/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Foundation

struct User: Codable {
  
  let username: String
  let avatarURL: URL
  
  enum CodingKeys: String, CodingKey {
    case username = "login"
    case avatarURL = "avatar_url"
  }
}
