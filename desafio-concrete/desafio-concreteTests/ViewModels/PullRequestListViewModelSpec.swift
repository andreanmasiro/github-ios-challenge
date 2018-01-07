//
//  PullRequestListViewModelSpec.swift
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

class PullRequestListViewModelSpec: QuickSpec {

  override func spec() {
    
    describe("PullRequestListViewModelSpec") {
      
      let fakeCoordinator = FakeSceneCoordinator()
      let fakeService = FakePullRequestService(bundle: Bundle(for: PullRequestListViewModelSpec.self))
      let repositoryName = "some name"
      
      var viewModel: PullRequestListViewModel!
      
      var disposeBag: DisposeBag!
      
      beforeEach {
        
        viewModel = PullRequestListViewModel(
          coordinator: fakeCoordinator,
          service: fakeService,
          repositoryName: repositoryName
        )
        disposeBag = DisposeBag()
      }
      
      context("when requested to load next page") {
        
        it("should start loading") {
          
          var loading: Bool?
          viewModel.loading.asObservable()
            .skip(1) //initial value
            .take(1)
            .subscribe(onNext: {
              loading = $0
            })
            .disposed(by: disposeBag)
          
          viewModel.loadNextPage()
          expect(loading).toEventually(beTrue())
        }
        
        it("should update sectioned pull requests") {
          
          var pullRequests: [PullRequest]?
          viewModel.sectionedPullRequests
            .drive(onNext: {
              pullRequests = $0[0].items
            })
            .disposed(by: disposeBag)
          
          viewModel.loadNextPage()
          expect(pullRequests).toEventuallyNot(beEmpty())
        }
        
        it("should finish loading") {
          
          var loading: Bool?
          viewModel.loading.asDriver()
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
      
      context("when show pull request action run") {
        
        it("should call coordinator transition") {
          
          var pulls = [PullRequest]()
          viewModel.sectionedPullRequests
            .drive(onNext: {
              pulls = $0[0].items
            })
            .disposed(by: disposeBag)
          
          viewModel.loadNextPage()
          
          expect(pulls).toEventuallyNot(beEmpty())
          
          let pull = pulls[0]
          
          var htmlURL: URL?
          fakeCoordinator.methodInvoked
            .subscribe(onNext: { (_, args) in
              guard case SceneTransition.push(_) = args[0],
                case Scene.pullRequest(let url) = args[1] else {
                  
                  fail("wrong method invoked")
                  return
              }
              
              htmlURL = url
            })
            .disposed(by: disposeBag)
          
          viewModel.showPullRequestAction.execute(pull)
          
          expect(htmlURL).toEventually(equal(pull.htmlURL))
        }
      }
    }
  }
}
