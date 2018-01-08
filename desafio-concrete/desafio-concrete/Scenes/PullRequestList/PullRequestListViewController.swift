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

class PullRequestListViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
  @IBOutlet weak var headerView: PullRequestHeaderView!
  
  var loading = false
  var loadNextPage: (() -> ())?
  var finishedLoading: Completable?
  
  let disposeBag = DisposeBag()
  
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

    viewModel.sectionedPullRequests
      .do(onNext: { (sections) in
        self.headerView.config(count: sections[0].items.count)
      })
      .drive(tableView.rx.items(dataSource: dataSource))
      .disposed(by: disposeBag)
    
    viewModel.repositoryName
      .drive(navigationItem.rx.title)
      .disposed(by: disposeBag)
    
    viewModel.loading.asDriver()
      .drive(loadIndicator.rx.isAnimating)
      .disposed(by: disposeBag)
    
    viewModel.errorMessage
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: {
        self.showErrorAlert(message: $0, retryHandler: { _ in
          viewModel.retry()
        })
      })
      .disposed(by: disposeBag)
    
    tableView.rx.itemSelected.asDriver()
      .drive(onNext: {
        self.tableView.deselectRow(at: $0, animated: true)
      })
      .disposed(by: disposeBag)
    
    tableView.rx.modelSelected(PullRequest.self).asDriver()
      .drive(onNext: {
        viewModel.showPullRequestAction.execute($0)
      })
      .disposed(by: disposeBag)
    
    loadNextPage = viewModel.loadNextPage
    finishedLoading = viewModel.finishedLoading.ignoreElements()
    setUpReloadable()
  }
  
  var dataSource: PullRequestsDataSource {
    
    return PullRequestCellFactory.dataSource
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
