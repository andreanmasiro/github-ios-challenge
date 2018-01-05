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

  private let pullRequests = Variable<[PullRequest]>([])
  private let service: PullRequestServiceType
  
  let sectionedPullRequests: Driver<[PullRequestsSection]>
  let repositoryName: Driver<String>
  let headerModels: Driver<[PullRequestHeaderModel]>
  
  init(service: PullRequestServiceType, repositoryName: String) {
    
    self.service = service
    
    self.repositoryName = Driver.just(repositoryName)
    
    self.sectionedPullRequests = pullRequests.asDriver()
      .map { [PullRequestsSection(model: "", items: $0)] }
    
    self.headerModels = pullRequests.asDriver()
      .map {
        
        let openCount = $0.filter { $0.open }.count
        let closedCount = $0.count - openCount
        
        return [PullRequestHeaderModel(openCount: openCount,
                                      closedCount: closedCount)]
      }
  }
}
