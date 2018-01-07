//
//  FakeSceneCoordinator.swift
//  desafio-concreteTests
//
//  Created by André Marques da Silva Rodrigues on 06/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import RxSwift

@testable import desafio_concrete

struct FakeSceneCoordinator: SceneCoordinatorType {
  
  let methodInvoked = PublishSubject<(Selector, [Any])>()
  
  func transition(_ transition: SceneTransition, to scene: Scene) -> Completable {
    methodInvoked.onNext((#function, [transition, scene]))
    return Completable.empty()
  }
  
  func pop(animated: Bool) -> Completable {
    methodInvoked.onNext((#function, [animated]))
    return Completable.empty()
  }
}
