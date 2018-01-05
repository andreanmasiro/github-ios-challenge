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

typealias PullRequestsSection = AnimatableSectionModel<PullRequestListCellModel, PullRequestListCellModel>

struct PullRequestListViewModel {
  
  let author = User.fake
  var pullRequests: [PullRequest] {
    return [
      PullRequest.fake(author: author),
      PullRequest.fake(author: author),
      PullRequest.fake(author: author)
    ]
  }
  var headerData: (openCount: Int, closedCount: Int) {
    let openCount = pullRequests.filter { $0.open }.count
    return (openCount, pullRequests.count - openCount)
  }
  
  
  var sectionedPullRequests: Driver<[PullRequestsSection]> {
    
    let headerModel = PullRequestListCellModel.pullRequestHeader(closedCount: headerData.closedCount, openCount: headerData.openCount)
    let items = pullRequests.map { $0.cellModel }
    
    let section = PullRequestsSection(model: headerModel, items: items)
    
    return Driver.just([section])
  }
}
