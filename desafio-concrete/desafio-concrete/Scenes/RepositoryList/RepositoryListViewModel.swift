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
  
  var fakeOwner = User.fake
  var fakeRepositories: [Repository] {
    return [
      Repository.fake(owner: fakeOwner),
      Repository.fake(owner: fakeOwner),
      Repository.fake(owner: fakeOwner)
    ]
  }
  
  var sectionedRepositories: Driver<[RepositoriesSection]> {
    
    let items = fakeRepositories.map { $0.cellModel }
    let section = RepositoriesSection(model: "", items: items)
    
    return Driver.just([section])
  }
}
