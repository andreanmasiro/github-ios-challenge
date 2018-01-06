//
//  PullRequestListViewController.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 05/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

typealias PullRequestsDataSource = RxTableViewSectionedAnimatedDataSource<PullRequestsSection>

class PullRequestListViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
  
  let tableViewDelegate = PullRequestListTableViewDelegate()
  
  let bottomMargin = CGFloat(10)
  var reloadBottomOffsetThreshold: CGFloat {
    return bottomMargin + loadIndicator.bounds.height
  }
  
  var loading = false
  var loadNextPage: (() -> ())?
  
  let bag = DisposeBag()
  
  override func viewDidLoad() {
    
    registerNibs()
    super.viewDidLoad()
  }
  
  func bindUI(viewModel: PullRequestListViewModel) {
    
    let dataSource = self.dataSource

    viewModel.headerModels
      .drive(tableViewDelegate.headerModels)
      .disposed(by: bag)
    
    tableView.rx.setDelegate(tableViewDelegate)
      .disposed(by: bag)
    
    viewModel.sectionedPullRequests
      .drive(tableView.rx.items(dataSource: dataSource))
      .disposed(by: bag)
    
    viewModel.repositoryName
      .drive(navigationItem.rx.title)
      .disposed(by: bag)
    
    loadNextPage = viewModel.loadNextPage
    setUpReloadable()
  }
  
  func registerNibs() {
    
    tableView.registerNib(PullRequestHeaderTableViewCell.self)
    tableView.registerNib(PullRequestTableViewCell.self)
  }
  
// MARK: Table view sources
  var dataSource: PullRequestsDataSource {
    
    return PullRequestsDataSource(
      configureCell: {
        (_, tableView, indexPath, model) -> UITableViewCell in
        
        guard let cell = tableView
          .dequeueReusableCellWithDefaultIdentifier(
            PullRequestTableViewCell.self,
            for: indexPath
          ) else {
            return UITableViewCell()
        }
        
        cell.config(model: model)
        
        return cell
      }
    )
  }
}

extension PullRequestListViewController: PageReloadableViewController {

  var scrollView: UIScrollView {
    return tableView
  }
}
