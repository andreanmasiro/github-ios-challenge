//
//  PullRequestListViewControllerSpec.swift
//  desafio-concreteTests
//
//  Created by André Marques da Silva Rodrigues on 07/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit
import Quick
import Nimble
import RxSwift
import RxCocoa

@testable import desafio_concrete

class PullRequestListViewControllerSpec: QuickSpec {

  override func spec() {
    
    describe("PullRequestListViewControllerSpec") {
      
      context("after binding UI") {
        
        let bundle = Bundle(for: PullRequestListViewControllerSpec.self)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let pullRequestListViewController = storyboard
          .instantiateViewController(withIdentifier: StoryboardIdentifier.pullRequestList) as! PullRequestListViewController
        pullRequestListViewController.loadViewIfNeeded()
        
        var fakeService: FakePullRequestService!
        let fakeCoordinator = FakeSceneCoordinator()
        
        var viewModel: PullRequestListViewModel!
        
        var disposeBag: DisposeBag!
        
        let setUp = {
          
          disposeBag = DisposeBag()
          
          fakeService = FakePullRequestService(bundle: bundle)
          viewModel = PullRequestListViewModel(coordinator: fakeCoordinator, service: fakeService, repositoryName: "")
          
          pullRequestListViewController.bindUI(viewModel: viewModel)
        }
        
        describe("table view rows") {
          
          beforeEach(setUp)
          
          it("should match the count of repositories") {
            
            var pulls: [PullRequest]!
            
            viewModel.sectionedPullRequests
              .drive(onNext: { pulls = $0[0].items })
              .disposed(by: disposeBag)
            
            viewModel.loadNextPage()
            
            let tableView = pullRequestListViewController.tableView!
            
            expect(tableView.numberOfSections)
              .toEventually(be(1))
            
            expect(tableView.numberOfRows(inSection: 0))
              .toEventually(be(pulls.count))
          }
        }
        
        context("when selecting rows") {
          
          beforeEach(setUp)
          
          it("should trigger coordinator's transition") {
            
            viewModel.loadNextPage()
            
            let tableView = pullRequestListViewController.tableView!
            
            waitUntil { done in
              
              viewModel.sectionedPullRequests
                .drive(onNext: { section in
                  if !section[0].items.isEmpty {
                    done()
                  }
                })
                .disposed(by: disposeBag)
            }
            
            var calledTransition: Bool?
            fakeCoordinator.methodInvoked
              .subscribe(onNext: { _, args in
                
                if args[0] is SceneTransition,
                  case Scene.pullRequest(_) = args[1] {
                  calledTransition = true
                } else {
                  calledTransition = false
                }
              })
              .disposed(by: disposeBag)
            
            guard let delegate = tableView.delegate else {
              fail("nil tableview delegate")
              return
            }
            delegate.tableView?(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
            
            expect(calledTransition).toEventually(beTrue())
          }
        }
      }
    }
  }
}
