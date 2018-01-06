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
  
  private let coordinator: SceneCoordinator
  private let lastPageLoaded = Variable<Int>(0)
  
  private let service: RepositoryServiceType
  private let repositories = Variable<[Repository]>([])
  
  private let bag = DisposeBag()
  
  let sectionedRepositories: Driver<[RepositoriesSection]>
  let loading = Variable<Bool>(false)
  
  init(coordinator: SceneCoordinator, service: RepositoryServiceType) {
    self.coordinator = coordinator
    self.service = service
    
    self.sectionedRepositories = repositories.asDriver()
      .map { [RepositoriesSection(model: "", items: $0)] }
    bindOutput()
  }
  
  private func bindOutput() {
    
    service.repositories
      .do(onNext: { _ in
        self.loading.value = false
      })
      .bind(to: repositories)
      .disposed(by: bag)
    
    lastPageLoaded.asObservable()
      .skip(1)
      .subscribe(onNext: {
        self.loading.value = true
        self.service.loadRepositoryList(page: $0)
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
