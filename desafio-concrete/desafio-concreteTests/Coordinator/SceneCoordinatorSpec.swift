//
//  SceneCoordinatorSpec.swift
//  desafio-concreteTests
//
//  Created by André Marques da Silva Rodrigues on 07/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit
import Quick
import Nimble
import RxSwift

@testable import desafio_concrete

class SceneCoordinatorSpec: QuickSpec {

  override func spec() {
    
    describe("SceneCoordinatorSpec") {
      
      var window: UIWindow!
      var coordinator: SceneCoordinator!
      var disposeBag: DisposeBag!
      
      let setUp = {
          disposeBag = DisposeBag()
          window = UIWindow()
          coordinator = SceneCoordinator(window: window)
      }
      
      context("when transitioning") {
        
        context("root") {
          
          beforeEach(setUp)
          
          it("should set the correct view controller as window's root") {
            
            var typeMatches: Bool?
            let scene = FakeScene.fakeNav
            coordinator.transition(.root, to: scene)
              .subscribe(onCompleted: {
                
                let rootViewController = window.rootViewController!
                typeMatches = rootViewController.classForCoder === scene.viewController.classForCoder
              })
              .disposed(by: disposeBag)
            
            expect(typeMatches).toEventually(beTrue())
          }
        }
        
        context("push") {
          
          beforeEach(setUp)
          
          it("should add the new view controller to the navigation stack") {
            
            let navScene = FakeScene.fakeNav
            let scene = FakeScene.fake
            
            var typeMatches: Bool?
            coordinator.transition(.root, to: navScene)
              .andThen(coordinator.transition(.push(animated: false), to: scene))
              .subscribe(onCompleted: {
                
                let rootViewController = window.rootViewController as! UINavigationController
                
                typeMatches = rootViewController.topViewController!.classForCoder === scene.viewController.classForCoder
              })
              .disposed(by: disposeBag)
            
            expect(typeMatches).toEventually(beTrue())
          }
          
          context("no root controller") {
            
            beforeEach(setUp)
      
            it("should fail with error") {
              
              let scene = FakeScene.fake
              
              var error: Error?
              coordinator.transition(.push(animated: false), to: scene)
                .subscribe(onError: {
                  error = $0
                })
                .disposed(by: disposeBag)
              
              expect(error)
                .toEventually(matchError(SceneCoordinatorError
                  .noRootViewController))
            }
          }
          
          context("no navigation controller") {
            
            beforeEach(setUp)
            
            it("should fail with error") {
              
              let scene = FakeScene.fake
              
              var error: Error?
              coordinator.transition(.root, to: scene)
                .andThen(coordinator.transition(.push(animated: false), to: scene))
                .subscribe(onError: {
                  error = $0
                })
                .disposed(by: disposeBag)
              
              expect(error)
                .toEventually(matchError(SceneCoordinatorError
                  .pushFromNonNavigationController))
            }
          }
        }
      }
    }
  }
}
