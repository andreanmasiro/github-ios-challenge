//
//  RepositoryListViewModel.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 04/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Foundation
import RxDataSources
import RxSwift
import RxCocoa

typealias RepositoriesSection = AnimatableSectionModel<String, RepositoryListCellModel>

struct RepositoryListViewModel {
  
  var fakeOwner = User(username: "andreanmasiro",
                       fullName: "Andre Rodrigues",
                       avatarPath: "https://bitbucket.org/account/andreanmasiro/avatar/192/?ts=1515094371")
  var fakeRepositories: [Repository] {
    return [
      Repository(id: 1,
                 name: "R1",
                 description: "Super repository from great andreanmasiro",
                 branchCount: 3,
                 stargazersCount: 29000,
                 owner: fakeOwner)
    ]
  }
  
  var sectionedRepositories: Driver<[RepositoriesSection]> {
    
    let items = fakeRepositories.map {
      RepositoryListCellModel
        .repository(id: $0.id,
                    name: $0.name,
                    description: $0.description,
                    branchCount: $0.branchCount,
                    stargazersCount: $0.stargazersCount,
                    ownerUsername: $0.owner.username,
                    ownerFullName: $0.owner.fullName)
    }
    let section = RepositoriesSection(model: "", items: items)
    
    return Driver.just([section])
  }
}
