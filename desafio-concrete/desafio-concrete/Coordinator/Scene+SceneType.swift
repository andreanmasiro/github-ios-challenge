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
    
    let storyboardVC = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier)
    
    switch self {
    case .repositoryList(let viewModel):
      
      guard let nc = storyboardVC as? UINavigationController,
        let vc = nc.topViewController as? RepositoryListViewController else {
        return UIViewController()
      }
      
      vc.loadViewIfNeeded()
      vc.bindUI(viewModel: viewModel)
      
      return nc
      
    case .pullRequestList(let viewModel):
      
      guard let vc = storyboardVC as? PullRequestListViewController else {
        return UIViewController()
      }
      
      vc.loadViewIfNeeded()
      vc.bindUI(viewModel: viewModel)
      
      return vc
      
    case .pullRequest(let url):
      guard let vc = storyboardVC as? PullRequestViewController else {
        return UIViewController()
      }
      
      vc.loadViewIfNeeded()
      vc.load(contentsOfURL: url)
      
      return vc
    }
  }
}
