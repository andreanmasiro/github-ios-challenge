//
//  Scene+Fakes.swift
//  desafio-concreteTests
//
//  Created by André Marques da Silva Rodrigues on 07/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit

@testable import desafio_concrete

enum FakeScene: SceneType {
  case fake
  case fakeNav
  
  var viewController: UIViewController {
    
    switch self {
    case .fake: return UIViewController()
    case .fakeNav: return UINavigationController()
    }
  }
}
