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
  
  var sectionedRepositories: Driver<[RepositoriesSection]> {
    
    let section = RepositoriesSection(model: "", items: [])
    
    return Driver.just([section])
  }
}
