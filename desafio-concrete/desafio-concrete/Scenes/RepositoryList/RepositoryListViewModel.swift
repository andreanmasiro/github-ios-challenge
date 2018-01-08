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

struct RepositoryListViewModel {
  
  private let coordinator: SceneCoordinatorType
  private let service: RepositoryServiceType
  
  private let trial = PublishSubject<Void>()
  private let lastPageLoaded = Variable<Int>(0)
  
  private let repositories = Variable<[Repository]>([])
  
  private let bag = DisposeBag()
  
  let sectionedRepositories: Driver<[RepositoriesSection]>
  let loadingErrorMessage: Observable<String>
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
    
    loadingErrorMessage = service.loadingError
      .debug()
      .map {
        $0.localizedDescription
      }
    
    bindOutput()
  }
  
  private func bindOutput() {
    
    trial.withLatestFrom(lastPageLoaded.asObservable())
      .takeUntil(finishedLoading)
      .do(onNext: { _ in
        self.loading.value = true
      })
      .flatMap { self.service.repositories(page: $0) }
      .do(onNext: { _ in
        self.loading.value = false
      })
      .catchError { error in
        
        return Observable.just([])
      }
      .scan([Repository](), accumulator: +)
      .bind(to: repositories)
      .disposed(by: bag)
  }
  
  func loadNextPage() {
    lastPageLoaded.value += 1
    trial.onNext(())
  }
  
  var retryAction: CocoaAction {
    return CocoaAction { _ in
      self.trial.onNext(())
      return .empty()
    }
  }
  
  var showPullRequestsAction: Action<Repository, Void> {
    return Action {
      
      let service = PullRequestService(apiURL: $0.pullsURL)
      let viewModel = PullRequestListViewModel(coordinator: self.coordinator, service: service, repositoryName: $0.name)
      
      self.coordinator.transition(.push(animated: true),
                                  to: Scene.pullRequestList(viewModel))
      
      return Observable.empty()
    }
  }
}
