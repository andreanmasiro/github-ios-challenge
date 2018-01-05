//
//  Scene+ViewController.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 05/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit

extension Scene {
  
  var storyboardIdentifier: String {
    
    switch self {
    case .repositoryList: return StoryboardIdentifier.repositoryListNav
    case .pullRequestList: return StoryboardIdentifier.pullRequestList
    }
  }
  
  var viewController: UIViewController {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    switch self {
    case .repositoryList(let viewModel):
      
      guard let nc = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? UINavigationController,
        let vc = nc.topViewController as? RepositoryListViewController else {
        return UIViewController()
      }
      
      vc.loadViewIfNeeded()
      vc.bindUI(viewModel: viewModel)
      
      return vc
      
    case .pullRequestList(let viewModel):
      
      guard let vc = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? PullRequestListViewController else {
        return UIViewController()
      }
      
      vc.loadViewIfNeeded()
      vc.bindUI(viewModel: viewModel)
      
      return vc
    }
  }
}
