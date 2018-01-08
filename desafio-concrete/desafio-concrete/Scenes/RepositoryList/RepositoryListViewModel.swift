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
  
  let finishedLoading = PublishSubject<Void>()
  let loading = Variable<Bool>(false)
  
  let errorMessage: Observable<String>
  private let errorSubject = PublishSubject<ServiceError>()
  
  init(coordinator: SceneCoordinatorType, service: RepositoryServiceType) {
    self.coordinator = coordinator
    self.service = service
    
    self.sectionedRepositories = repositories.asDriver()
      .map { [RepositoriesSection(model: "", items: $0)] }
    
    service.finishedLoading
      .bind(to: finishedLoading)
      .disposed(by: bag)
    
    self.errorMessage = errorSubject.asObserver()
      .map { $0.localizedDescription }
    
    bindOutput()
  }
  
  private func bindOutput() {
    
    trial.withLatestFrom(lastPageLoaded.asObservable())
      .takeUntil(finishedLoading)
      .do(onNext: { _ in
        self.loading.value = true
      })
      .flatMap {
        self.service.repositories(page: $0)
          .catchError { error in
            
            let nserror = error as NSError
            self.errorSubject.onNext(.withNSError(nserror))
            
            return Observable.empty()
        }
      }
      .do(onNext: { _ in
        self.loading.value = false
      })
      .catchErrorJustReturn([])
      .debug("after error", trimOutput: true)
      .scan([Repository](), accumulator: +)
      .bind(to: repositories)
      .disposed(by: bag)
  }
  
  func loadNextPage() {
    lastPageLoaded.value += 1
    retryAction.execute(())
  }
  
  var retryAction: CocoaAction {
    return CocoaAction { _ in
      self.trial.onNext(())
      print("retry")
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
