//
//  PullRequestListCellModel.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 05/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Foundation
import RxDataSources

enum PullRequestListCellModel: IdentifiableType, Equatable {
  
  case pullRequest(
    id: Int,
    title: String,
    description: String,
    authorUsername: String,
    authorFullName: String,
    authorAvatarURL: URL
  )
  
  case pullRequestHeader(
    closedCount: Int,
    openCount: Int
  )
  
  var identity: Int {
    
    switch self {
    case .pullRequest(let id, _, _, _, _, _):
      return id
    case .pullRequestHeader(_, _):
      return 0
    }
  }
  
  static func ==(lhs: PullRequestListCellModel, rhs: PullRequestListCellModel) -> Bool {
    
    switch (lhs, rhs) {
    case (.pullRequest(let id1, _, _, _, _, _),
          .pullRequest(let id2, _, _, _, _, _)):
      return id1 == id2
    default: return false
    }
  }
}
