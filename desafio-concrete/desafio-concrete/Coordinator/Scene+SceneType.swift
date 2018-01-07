//
//  Scene+ViewController.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 05/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit

extension Scene: SceneType {
  
  var storyboardIdentifier: String {
    
    switch self {
    case .repositoryList: return StoryboardIdentifier.repositoryListNav
    case .pullRequestList: return StoryboardIdentifier.pullRequestList
    case .pullRequest: return StoryboardIdentifier.pullRequest
    }
  }
  
  var viewController: UIViewController {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    let storyboardViewController = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier)
    
    switch self {
    case .repositoryList(let viewModel):
      
      guard let navigationController = storyboardViewController as? UINavigationController,
        let viewController = navigationController.topViewController as? RepositoryListViewController else {
        return UIViewController()
      }
      
      viewController.loadViewIfNeeded()
      viewController.bindUI(viewModel: viewModel)
      
      return navigationController
      
    case .pullRequestList(let viewModel):
      
      guard let viewController = storyboardViewController as? PullRequestListViewController else {
        return UIViewController()
      }
      
      viewController.loadViewIfNeeded()
      viewController.bindUI(viewModel: viewModel)
      
      return viewController
      
    case .pullRequest(let url):
      guard let viewController = storyboardViewController as? PullRequestViewController else {
        return UIViewController()
      }
      
      viewController.loadViewIfNeeded()
      viewController.load(contentsOfURL: url)
      
      return viewController
    }
  }
}
