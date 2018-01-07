//
//  RepositoryListViewModelSpec.swift
//  desafio-concreteTests
//
//  Created by André Marques da Silva Rodrigues on 06/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxCocoa
import RxDataSources
import Action

@testable import desafio_concrete

class RepositoryListViewModelSpec: QuickSpec {
  
  override func spec() {
    
    describe("RepositoryListViewModelSpec") {
      
      let loadTime = TimeInterval(1)
      let fakeCoordinator = FakeSceneCoordinator()
      let fakeService = FakeRepositoryService(bundle: Bundle(for: RepositoryListViewModelSpec.self), loadTime: loadTime)
      
      var viewModel: RepositoryListViewModel!
      
      var disposeBag: DisposeBag!
      
      beforeEach {
        viewModel = RepositoryListViewModel(coordinator: fakeCoordinator, service: fakeService)
        disposeBag = DisposeBag()
      }
      context("when requested to load next page") {
        
        it("should start loading") {
          
          var loading: Bool?
          viewModel.loading.asDriver()
            .drive(onNext: {
              loading = $0
            })
            .disposed(by: disposeBag)
          
          viewModel.loadNextPage()
          expect(loading).toEventually(beTrue())
        }
        
        it("should update sectioned repositories") {
          
          var repositories: [Repository]?
          viewModel.sectionedRepositories
            .drive(onNext: {
              repositories = $0[0].items
            })
            .disposed(by: disposeBag)
          
          viewModel.loadNextPage()
          expect(repositories).toEventuallyNot(beEmpty())
        }
        
        it("should finish loading") {
          
          var loading: Bool?
          viewModel.loading.asDriver()
            .skip(1)
            .drive(onNext: {
              loading = $0
            })
            .disposed(by: disposeBag)
          
          viewModel.loadNextPage()
          expect(loading).toEventually(beFalse())
          
          var finishedLoading: Bool?
          viewModel.finishedLoading
            .subscribe(onCompleted: {
              finishedLoading = true
            })
            .disposed(by: disposeBag)
          
          viewModel.loadNextPage()
          expect(finishedLoading).toEventually(beTruthy())
        }
      }
      
      context("when show pull requests action run") {
        
        it("should call coordinator transition") {
          
          var repos = [Repository]()
          viewModel.sectionedRepositories
            .drive(onNext: {
              repos = $0[0].items
            })
            .disposed(by: disposeBag)
          
          viewModel.loadNextPage()
          
          expect(repos).toEventuallyNot(beEmpty())
          
          let repo = repos[0]
          var calledPush: Bool?
          fakeCoordinator.methodInvoked
            .subscribe(onNext: { (_, args) in
              guard case SceneTransition.push(_) = args[0],
                case Scene.pullRequestList(_) = args[1] else {
                  
                  fail("wrong method invoked")
                  return
              }
              
              calledPush = true
            })
            .disposed(by: disposeBag)
          
          viewModel.showPullRequestsAction.execute(repo)
          
          expect(calledPush).toEventually(beTrue())
        }
      }
    }
  }
}
