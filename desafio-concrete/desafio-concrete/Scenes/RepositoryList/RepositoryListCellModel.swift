//
//  RepositoryListCellModel.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 04/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Foundation
import RxDataSources

enum RepositoryListCellModel: IdentifiableType, Equatable {
  
  case repository(
    id: Int,
    name: String,
    description: String,
    branchCount: Int,
    stargazersCount: Int,
    ownerUsername: String,
    ownerFullName: String,
    ownerAvatarURL: URL
  )
  
  var identity: Int {
    switch self {
    case .repository(let id, _, _, _, _, _, _, _):
      return id
    }
  }
  
  static func ==(lhs: RepositoryListCellModel, rhs: RepositoryListCellModel) -> Bool {
    
    switch (lhs, rhs) {
    case (.repository(let id1, _, _, _, _, _, _, _),
      .repository(let id2, _, _, _, _, _, _, _)):
      return id1 == id2
    }
  }
}
