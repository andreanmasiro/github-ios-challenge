//
//  MessengerViewController.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 08/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit

protocol MessengerViewController {
  
  @discardableResult
  func showAlert(title: String, message: String, actionData: [(title: String, handler: ((UIAlertAction) -> ())?, style: UIAlertActionStyle)]) -> UIAlertController
}

extension MessengerViewController where Self: UIViewController {
  
  @discardableResult
  func showAlert(title: String, message: String, actionData: [(title: String, handler: ((UIAlertAction) -> ())?, style: UIAlertActionStyle)]) -> UIAlertController {
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    actionData.forEach {
      let action = UIAlertAction(title: $0.title, style: $0.style, handler: $0.handler)
      alertController.addAction(action)
    }
    
    self.present(alertController, animated: true, completion: nil)
    
    return alertController
  }
  
  func showErrorAlert(message: String, retryHandler: @escaping (UIAlertAction) -> ()) {
    
    showAlert(title: "An error ocurred ❌",
              message: message,
              actionData: [("Retry", retryHandler, .default)])
  }
}

extension UIViewController: MessengerViewController { }
