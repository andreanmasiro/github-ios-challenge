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
      
      let fakeCoordinator = FakeSceneCoordinator()
      let fakeService = FakeRepositoryService(bundle: Bundle(for: RepositoryListViewModelSpec.self))
      
      var viewModel: RepositoryListViewModel!
      
      var disposeBag: DisposeBag!
      
      context("when requested to load next page") {
      
        beforeEach {
          viewModel = RepositoryListViewModel(coordinator: fakeCoordinator, service: fakeService)
          disposeBag = DisposeBag()
        }
        
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
        
        it("should update sectioned repositories") {
          
          var repositories = [Repository]()
          viewModel.sectionedRepositories
            .filter { !$0[0].items.isEmpty }
            .drive(onNext: {
              repositories.append(contentsOf: $0[0].items)
            })
            .disposed(by: disposeBag)
          
          viewModel.loadNextPage()
          expect(repositories).toEventuallyNot(beEmpty())
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
        
        context("on error") {
          
          afterEach {
            fakeService.setError(nil)
          }
          
          context("service error") {
            
            it("should send error localizedDescription as message") {
              
              let noConnection = ServiceError.noConnection
              fakeService.setError(noConnection)
              
              var message: String?
              viewModel.errorMessage
                .subscribe(onNext: {
                  message = $0
                })
                .disposed(by: disposeBag)
              
              viewModel.loadNextPage()
              
              expect(message).toEventually(match(noConnection.localizedDescription))
            }
          }
          
          context("nserror") {
            
            it("should parse and send localizedDescription as message") {
              
              let error = NSError(domain: "", code: -1001, userInfo: nil)
              fakeService.setError(error)
              
              var message: String?
              viewModel.errorMessage
                .subscribe(onNext: {
                  message = $0
                })
                .disposed(by: disposeBag)
              
              viewModel.loadNextPage()
              
              expect(message).toEventually(match(ServiceError.timeout.localizedDescription))
            }
          }
        }
      }
      
      context("when show pull requests action run") {
        
        beforeEach {
          viewModel = RepositoryListViewModel(coordinator: fakeCoordinator, service: fakeService)
          disposeBag = DisposeBag()
        }
        
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
