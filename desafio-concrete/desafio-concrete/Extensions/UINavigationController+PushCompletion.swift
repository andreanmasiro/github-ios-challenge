//
//  UINavigationController+PushCompletion.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 07/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit

extension UINavigationController {

  func pushViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> ()) {
    
    CATransaction.begin()
    CATransaction.setCompletionBlock(completion)
    pushViewController(viewController, animated: animated)
    CATransaction.commit()
  }
}
