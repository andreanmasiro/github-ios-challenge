//
//  ViewController.swift
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

class RepositoryListViewControllerSpec: QuickSpec {
  
  override func spec() {
    
    describe("RepositoryListViewControllerSpec") {
      
      context("after binding UI") {
        
        let bundle = Bundle(for: RepositoryListViewControllerSpec.self)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let navigationController = storyboard
          .instantiateViewController(withIdentifier: StoryboardIdentifier.repositoryListNav) as! UINavigationController
        navigationController.loadViewIfNeeded()
        
        let repositoryListViewController = navigationController
          .topViewController as! RepositoryListViewController
        repositoryListViewController.loadViewIfNeeded()
        
        var fakeService: FakeRepositoryService!
        let fakeCoordinator = FakeSceneCoordinator()
        
        var viewModel: RepositoryListViewModel!
        
        var disposeBag: DisposeBag!
        
        let setUp = {
          
          disposeBag = DisposeBag()
          
          fakeService = FakeRepositoryService(bundle: bundle)
          viewModel = RepositoryListViewModel(coordinator: fakeCoordinator, service: fakeService)
          
          repositoryListViewController.bindUI(viewModel: viewModel)
        }
        
        describe("table view rows") {
          
          beforeEach(setUp)
          
          it("should match the count of repositories") {
            
            var repos: [Repository]!
            
            viewModel.sectionedRepositories
              .drive(onNext: { repos = $0[0].items })
              .disposed(by: disposeBag)
            
            viewModel.loadNextPage()
            
            let tableView = repositoryListViewController.tableView!
            
            expect(tableView.numberOfSections)
              .toEventually(be(1))
            
            expect(tableView.numberOfRows(inSection: 0))
              .toEventually(be(repos.count))
          }
        }
        
        context("when selecting rows") {
          
          beforeEach(setUp)
          
          it("should trigger coordinator's transition") {
            
            viewModel.loadNextPage()
            
            let tableView = repositoryListViewController.tableView!
            
            waitUntil { done in
              
              viewModel.sectionedRepositories
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
                  case Scene.pullRequestList(_) = args[1] {
                  calledTransition = true
                } else {
                  calledTransition = false
                }
              })
              .disposed(by: disposeBag)
            
            tableView.delegate!.tableView!(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
            
            expect(calledTransition).toEventually(beTrue())
          }
        }
      }
    }
  }
}
