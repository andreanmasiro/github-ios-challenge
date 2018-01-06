//
//  SceneCoordinator.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 05/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit
import RxSwift

enum SceneCoordinatorError: Error {
  
  // transition
  case noRootViewController
  case pushFromNonNavigationController
  
  // pop
  case popFromRoot
  case dismissRoot
}

class SceneCoordinator {
  
  private let window: UIWindow
  private var currentViewController: UIViewController?
  
  init(window: UIWindow) {
    self.window = window
  }
  
  @discardableResult
  func transition(_ transition: SceneTransition, to scene: Scene) -> Completable {
    
    let vc = scene.viewController
    
    switch transition {
      
    case .root:
      
      window.rootViewController = vc
      window.makeKeyAndVisible()
      
      currentViewController = vc
      return .empty()
      
    case .push(let animated):
      
      guard let nc = currentViewController as? UINavigationController else {
        return .error(currentViewController == nil ?
            SceneCoordinatorError.noRootViewController :
            SceneCoordinatorError.pushFromNonNavigationController)
      }
      
      return push(source: nc, viewController: vc, animated: animated)
      
    case .modal(let animated):
      
      guard let currentVC = currentViewController else {
        return .error(SceneCoordinatorError.noRootViewController)
      }
      
      currentViewController = vc
      return present(source: currentVC, viewController: vc, animated: animated)
    }
  }
  
  @discardableResult
  func pop(animated: Bool) -> Completable {
    
    if let nc = currentViewController as? UINavigationController {
      
      return pop(source: nc, animated: animated)
    
    } else if let presenter = currentViewController?.presentingViewController {
      currentViewController = presenter
      return dismiss(viewController: presenter, animated: animated)
    } else {
      
      return .error(SceneCoordinatorError.dismissRoot)
    }
  }
  
  private func push(source: UINavigationController, viewController: UIViewController, animated: Bool) -> Completable {
    
    source.pushViewController(viewController, animated: animated)
    return source.rx.delegate
      .sentMessage(#selector(UINavigationControllerDelegate
        .navigationController(_:didShow:animated:)))
      .ignoreElements()
  }
  
  private func present(source: UIViewController, viewController: UIViewController, animated: Bool) -> Completable {
    
    let subject = PublishSubject<Void>()
    
    source.present(viewController, animated: animated) {
      subject.onCompleted()
    }
    
    return subject.ignoreElements()
  }
  
  private func pop(source: UINavigationController, animated: Bool) -> Completable {
    
    let completable = source.rx.delegate
      .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
      .ignoreElements()
    
    guard source.popViewController(animated: animated) != nil else {
      return .error(SceneCoordinatorError.popFromRoot)
    }
    
    return completable
  }
  
  private func dismiss(viewController: UIViewController, animated: Bool) -> Completable {
    
    let subject = PublishSubject<Void>()
    viewController.dismiss(animated: animated) {
      subject.onCompleted()
    }
    
    return subject.ignoreElements()
  }
}
