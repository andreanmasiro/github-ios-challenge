//
//  PullRequestListViewModel.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 05/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Foundation
import RxDataSources
import RxSwift
import RxCocoa

typealias PullRequestsSection = AnimatableSectionModel<String, PullRequest>

struct PullRequestListViewModel {
  
  let repository: Variable<Repository>
  
  init(repository: Repository) {
    self.repository = Variable(repository)
  }
  var sectionedPullRequests: Driver<[PullRequestsSection]> {
    
    let section = PullRequestsSection(model: "", items: [])
    
    return Driver.just([section])
  }
}
