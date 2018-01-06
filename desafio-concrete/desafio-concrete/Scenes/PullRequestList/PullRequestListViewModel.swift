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

  
  private let coordinator: SceneCoordinator
  private let service: PullRequestServiceType
  
  private let lastPageLoaded = Variable<Int>(0)
  
  private let pullRequests = Variable<[PullRequest]>([])
  
  private let bag = DisposeBag()
  
  let loading = Variable<Bool>(false)
  let sectionedPullRequests: Driver<[PullRequestsSection]>
  let repositoryName: Driver<String>
  let headerModels: Driver<[PullRequestHeaderModel]>
  
  init(coordinator: SceneCoordinator, service: PullRequestServiceType, repositoryName: String) {
    
    self.coordinator = coordinator
    self.service = service
    
    self.repositoryName = Driver.just(repositoryName)
    
    self.sectionedPullRequests = pullRequests.asDriver()
      .map { [PullRequestsSection(model: "", items: $0)] }
    
    self.headerModels = pullRequests.asDriver()
      .map {
        
        let openCount = $0.filter { $0.closedAt == nil }.count
        let closedCount = $0.count - openCount
        
        return [PullRequestHeaderModel(openCount: openCount,
                                      closedCount: closedCount)]
      }
    bindOutput()
  }
  
  private func bindOutput() {
    
    service.pullRequests
      .do(onNext: { _ in
        self.loading.value = false
      })
      .bind(to: pullRequests)
      .disposed(by: bag)
    
    lastPageLoaded.asObservable()
      .skip(1)
      .subscribe(onNext: {
        self.loading.value = true
        self.service.loadPullRequestList(page: $0)
      })
      .disposed(by: bag)
  }
  
  func loadNextPage() {
    lastPageLoaded.value += 1
  }
}
