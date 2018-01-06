//
//  RepositoryListViewController.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 04/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa
import Action

class RepositoryListViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
  
  let tableViewDelegate = RepositoryTableViewDelegate()
  
  let bag = DisposeBag()
  
  var loading = false
  var loadNextPage: (() -> ())?
  var finishedLoading: Completable?
  
  override func viewDidLoad() {
    
    registerNibs()
    setUpTableView()
    super.viewDidLoad()
  }
  
  func registerNibs() {
    tableView.registerNib(RepositoryTableViewCell.self)
  }
  
  func setUpTableView() {
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = RepositoryTableViewCell.cellHeight
    
    tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomMargin, right: 0)
  }
  
  func bindUI(viewModel: RepositoryListViewModel) {
    
    viewModel.sectionedRepositories
      .drive(tableView.rx.items(dataSource: dataSource))
      .disposed(by: bag)
    
    tableView.rx.setDelegate(tableViewDelegate)
      .disposed(by: bag)
    
    tableView.rx.itemSelected
      .subscribe(onNext: { indexPath in
        self.tableView.deselectRow(at: indexPath, animated: true)
      })
      .disposed(by: bag)
    
    tableView.rx.modelSelected(Repository.self)
      .asDriver()
      .drive(onNext: {
        viewModel.showPullRequestsAction.execute($0)
      })
      .disposed(by: bag)
    
    let loadingDriver = viewModel.loading.asDriver()
    loadingDriver
      .drive(onNext: {
        self.loading = $0
      })
      .disposed(by: bag)
    
    loadingDriver
      .drive(loadIndicator.rx.isAnimating)
      .disposed(by: bag)
    
    loadNextPage = viewModel.loadNextPage
    finishedLoading = viewModel.finishedLoading.ignoreElements()
    setUpReloadable()
  }
  
  var dataSource: RepositoriesDataSource {
    
    return RepositoryCellFactory.dataSource
  }
}

extension RepositoryListViewController: PageReloadableViewController {
  
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
