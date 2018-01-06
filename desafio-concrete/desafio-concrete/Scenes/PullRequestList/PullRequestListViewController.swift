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
  @IBOutlet weak var headerView: PullRequestHeaderView!
  
  var loading = false
  var loadNextPage: (() -> ())?
  var finishedLoading: Completable?
  
  let bag = DisposeBag()
  
  override func viewDidLoad() {
    
    registerNibs()
    setUpTableView()
    super.viewDidLoad()
  }
  
  func registerNibs() {
    tableView.registerNib(PullRequestTableViewCell.self)
  }
  
  func setUpTableView() {
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = PullRequestTableViewCell.cellHeight
  }
  
  func bindUI(viewModel: PullRequestListViewModel) {
    
    let dataSource = self.dataSource

    viewModel.headerModel
      .drive(onNext: {
        self.headerView.config(model: $0)
      })
      .disposed(by: bag)
    
    viewModel.sectionedPullRequests
      .drive(tableView.rx.items(dataSource: dataSource))
      .disposed(by: bag)
    
    viewModel.repositoryName
      .drive(navigationItem.rx.title)
      .disposed(by: bag)
    
    viewModel.loading.asDriver()
      .drive(loadIndicator.rx.isAnimating)
      .disposed(by: bag)
    
    tableView.rx.itemSelected.asDriver()
      .drive(onNext: {
        self.tableView.deselectRow(at: $0, animated: true)
      })
      .disposed(by: bag)
    
    tableView.rx.modelSelected(PullRequest.self).asDriver()
      .drive(onNext: {
        viewModel.showPullRequestAction.execute($0)
      })
      .disposed(by: bag)
    
    loadNextPage = viewModel.loadNextPage
    finishedLoading = viewModel.finishedLoading.ignoreElements()
    setUpReloadable()
  }
  
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
  
  var bottomMargin: CGFloat {
    return 10
  }
  
  var reloadBottomOffsetThreshold: CGFloat {
    return bottomMargin + loadIndicator.bounds.height
  }
}
