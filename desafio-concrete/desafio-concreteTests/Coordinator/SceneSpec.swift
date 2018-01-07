//
//  SceneSpec.swift
//  desafio-concreteTests
//
//  Created by André Marques da Silva Rodrigues on 07/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit
import Quick
import Nimble

@testable import desafio_concrete

class SceneSpec: QuickSpec {

  override func spec() {
    
    describe("SceneSpec") {
      
      context("view controller") {
        
        let fakeCoordinator = FakeSceneCoordinator()
        let bundle = Bundle(for: SceneSpec.self)
        context("repository list") {
          
          let fakeService = FakeRepositoryService(bundle: bundle, loadTime: 0)
          let viewModel = RepositoryListViewModel(coordinator: fakeCoordinator, service: fakeService)
          
          let scene = Scene.repositoryList(viewModel)
          
          it("should return the storyboard identifier") {
            
            expect(scene.storyboardIdentifier) == StoryboardIdentifier.repositoryListNav
          }
          
          it("should return the view controller") {
            
            let viewController = scene.viewController as? UINavigationController
            
            expect(viewController).notTo(beNil())
            expect(viewController?.topViewController as? RepositoryListViewController).notTo(beNil())
          }
        }
        
        context("pull request list") {
          
          let fakeService = FakePullRequestService(bundle: bundle, loadTime: 0)
          let viewModel = PullRequestListViewModel(coordinator: fakeCoordinator, service: fakeService, repositoryName: "")
          
          let scene = Scene.pullRequestList(viewModel)
          
          it("should return the storyboard identifier") {
            
            expect(scene.storyboardIdentifier) == StoryboardIdentifier.pullRequestList
          }
          
          it("should return the view controller") {
            
            let viewController = scene.viewController as? PullRequestListViewController
            expect(viewController).notTo(beNil())
          }
        }
        
        context("pull request") {
          
          let url = URL(string: "www.fake.com")!
          
          let scene = Scene.pullRequest(url)
          
          it("should return the storyboard identifier") {
            
            expect(scene.storyboardIdentifier) == StoryboardIdentifier.pullRequest
          }
          
          it("should return the view controller") {
            
            let viewController = scene.viewController as? PullRequestViewController
            expect(viewController).notTo(beNil())
          }
        }
      }
    }
  }
}
