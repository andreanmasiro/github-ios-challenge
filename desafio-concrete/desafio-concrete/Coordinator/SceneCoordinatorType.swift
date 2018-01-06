//
//  SceneCoordinatorType.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 06/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType {
  
  @discardableResult
  func transition(_ transition: SceneTransition, to scene: Scene) -> Completable
  
  @discardableResult
  func pop(animated: Bool) -> Completable
}
