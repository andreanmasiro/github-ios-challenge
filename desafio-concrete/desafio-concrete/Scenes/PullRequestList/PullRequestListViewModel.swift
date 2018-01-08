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

struct PullRequestListViewModel {
  
  private let coordinator: SceneCoordinatorType
  private let service: PullRequestServiceType
  
  private let trial = PublishSubject<Void>()
  private let lastPageLoaded = Variable<Int>(0)
  
  private let pullRequests = Variable<[PullRequest]>([])
  
  let errorMessage: Observable<String>
  private let errorSubject = PublishSubject<ServiceError>()
  
  private let disposeBag = DisposeBag()
  
  let finishedLoading = PublishSubject<Void>()
  let loading = Variable<Bool>(false)
  
  let sectionedPullRequests: Driver<[PullRequestsSection]>
  
  let repositoryName: Driver<String>
  
  init(coordinator: SceneCoordinatorType, service: PullRequestServiceType, repositoryName: String) {
    
    self.coordinator = coordinator
    self.service = service
    
    self.repositoryName = Driver.just(repositoryName)
    
    self.sectionedPullRequests = pullRequests.asDriver()
      .map { [PullRequestsSection(model: "", items: $0)] }
    
    service.finishedLoading
      .bind(to: finishedLoading)
      .disposed(by: disposeBag)
    
    self.errorMessage = errorSubject.asObservable()
      .map { $0.localizedDescription }
    
    bindOutput()
  }
  
  private func bindOutput() {
    
    loading.value = true
    trial.withLatestFrom(lastPageLoaded.asObservable())
      .takeUntil(finishedLoading)
      .do(onNext: { _ in
        self.loading.value = true
      })
      .flatMap {
        self.service.pullRequests(page: $0)
          .catchError { error in
            
            let nserror = error as NSError
            self.errorSubject.onNext(.withNSError(nserror))
            
            return Observable.empty()
          }
      }
      .do(onNext: { _ in
        self.loading.value = false
      })
      .scan([PullRequest](), accumulator: +)
      .bind(to: pullRequests)
      .disposed(by: disposeBag)
  }
  
  func loadNextPage() {
    lastPageLoaded.value += 1
    retry()
  }
  
  func retry() {
    trial.onNext(())
  }
  
  var showPullRequestAction: Action<PullRequest, Void> {
    return Action {
      
      self.coordinator.transition(.push(animated: true), to: Scene.pullRequest($0.htmlURL))
      return Observable.empty()
    }
  }
}
