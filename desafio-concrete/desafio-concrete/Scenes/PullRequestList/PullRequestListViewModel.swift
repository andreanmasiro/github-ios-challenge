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
import Action

typealias PullRequestsSection = AnimatableSectionModel<String, PullRequest>

struct PullRequestListViewModel {
  
  private let coordinator: SceneCoordinator
  private let service: PullRequestServiceType
  
  private let lastPageLoaded = Variable<Int>(0)
  private let pullRequests = Variable<[PullRequest]>([])
  
  private let bag = DisposeBag()
  
  let finishedLoading = PublishSubject<Void>()
  let loading = Variable<Bool>(false)
  
  let sectionedPullRequests: Driver<[PullRequestsSection]>
  
  let repositoryName: Driver<String>
  let headerModel: Driver<PullRequestHeaderModel>
  
  init(coordinator: SceneCoordinator, service: PullRequestServiceType, repositoryName: String) {
    
    self.coordinator = coordinator
    self.service = service
    
    self.repositoryName = Driver.just(repositoryName)
    
    self.sectionedPullRequests = pullRequests.asDriver()
      .map { [PullRequestsSection(model: "", items: $0)] }
    
    self.headerModel = pullRequests.asDriver()
      .map(PullRequestHeaderModel.init)
    
    service.finishedLoading
      .bind(to: finishedLoading)
      .disposed(by: bag)
    
    bindOutput()
  }
  
  private func bindOutput() {
    
    loading.value = true
    lastPageLoaded.asObservable().skip(1)
      .takeUntil(finishedLoading)
      .do(onNext: { _ in
        self.loading.value = true
      })
      .flatMap { self.service.pullRequests(page: $0) }
      .do(onNext: { _ in
        self.loading.value = false
      })
      .subscribe(onNext: {
        self.pullRequests.value.append(contentsOf: $0)
      })
      .disposed(by: bag)
  }
  
  var showPullRequestAction: Action<PullRequest, Void> {
    return Action {
      
      self.coordinator.transition(.push(true), to: .pullRequest($0.htmlURL))
      return Observable.empty()
    }
  }
  
  func loadNextPage() {
    lastPageLoaded.value += 1
  }
}
