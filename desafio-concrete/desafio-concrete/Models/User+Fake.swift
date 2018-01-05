//
//  User+Fake.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 05/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Foundation

extension User {
  
  static var fake: User {
    let fake = User(username: "andreanmasiro",
                         fullName: "Andre Rodrigues",
                         avatarPath: "https://bitbucket.org/account/andreanmasiro/avatar/192/?ts=1515094371")
    return fake
  }
}
