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
import Action

typealias RepositoriesSection = AnimatableSectionModel<String, Repository>

struct RepositoryListViewModel {
  
  private let coordinator: SceneCoordinatorType
  private let service: RepositoryServiceType
  
  private let lastPageLoaded = Variable<Int>(0)
  
  private let repositories = Variable<[Repository]>([])
  
  private let bag = DisposeBag()
  
  let sectionedRepositories: Driver<[RepositoriesSection]>
  let finishedLoading = PublishSubject<Void>()
  let loading = Variable<Bool>(false)
  
  init(coordinator: SceneCoordinatorType, service: RepositoryServiceType) {
    self.coordinator = coordinator
    self.service = service
    
    self.sectionedRepositories = repositories.asDriver()
      .map { [RepositoriesSection(model: "", items: $0)] }
    
    service.finishedLoading
      .bind(to: finishedLoading)
      .disposed(by: bag)
    bindOutput()
  }
  
  private func bindOutput() {
    
    lastPageLoaded.asObservable().skip(1)
      .takeUntil(finishedLoading)
      .do(onNext: { _ in
        self.loading.value = true
      })
      .flatMap { self.service.repositories(page: $0) }
      .do(onNext: { _ in
        self.loading.value = false
      })
      .subscribe(onNext: {
        self.repositories.value.append(contentsOf: $0)
      })
      .disposed(by: bag)
  }
  
  var showPullRequestsAction: Action<Repository, Void> {
    return Action {
      
      let service = PullRequestService(apiURL: $0.pullsURL)
      let viewModel = PullRequestListViewModel(coordinator: self.coordinator, service: service, repositoryName: $0.name)
      
      self.coordinator.transition(.push(true),
                                  to: .pullRequestList(viewModel))
      
      return Observable.empty()
    }
  }
  
  func loadNextPage() {
    lastPageLoaded.value += 1
  }
}
