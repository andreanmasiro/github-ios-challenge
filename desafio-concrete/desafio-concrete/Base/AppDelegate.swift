//
//  AppDelegate.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 04/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    #if !TESTING
      
      let window = UIWindow(frame: UIScreen.main.bounds)
      let coordinator = SceneCoordinator(window: window)
      
      let repositoryService = RepositoryService(apiPath: APIPaths.repositories)
      
      let repositoryViewModel = RepositoryListViewModel(coordinator: coordinator, service: repositoryService)
      
      coordinator.transition(.root,
                             to: .repositoryList(repositoryViewModel))
      
      self.window = window
    #endif
    return true
  }
}

