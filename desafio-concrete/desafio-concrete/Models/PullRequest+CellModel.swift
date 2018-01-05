//
//  PullRequest+CellModel.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 05/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Foundation

extension PullRequest {
  
  var cellModel: PullRequestListCellModel {
    
    guard let url = URL(string: author.avatarPath) else {
      fatalError("invalid avatar url")
    }
    return .pullRequest(id: id,
                        title: title,
                        description: description,
                        authorUsername: author.username,
                        authorFullName: author.fullName,
                        authorAvatarURL: url)
  }
}
