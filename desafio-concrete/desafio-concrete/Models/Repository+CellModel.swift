//
//  Repository+CellModel.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 05/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Foundation

extension Repository {
  
  var cellModel: RepositoryListCellModel {
    
    return .repository(id: id,
                       name: name,
                       description: description,
                       branchCount: branchCount,
                       stargazersCount: stargazersCount,
                       ownerUsername: owner.username,
                       ownerFullName: owner.fullName)
  }
}
