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

typealias RepositoriesSection = AnimatableSectionModel<String, Repository>

struct RepositoryListViewModel {
  
  private let service: RepositoryServiceType
  private let repositories = Variable<[Repository]>([])
  
  var sectionedRepositories: Driver<[RepositoriesSection]>
  
  init(service: RepositoryServiceType) {
    self.service = service
    
    sectionedRepositories = repositories.asDriver()
      .map { [RepositoriesSection(model: "", items: $0)] }
  }
}
