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

typealias RepositoriesDataSource = RxTableViewSectionedAnimatedDataSource<RepositoriesSection>

class RepositoryListViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
  let bag = DisposeBag()
  let tableViewDelegate = RepositoryTableViewDelegate()
  let bottomMargin = CGFloat(10)
  lazy var reloadBottomOffsetThreshold = {
    return $0 + $1
  }(bottomMargin, loadIndicator.bounds.height)
  
  override func viewDidLoad() {
    
    registerNibs()
    setUpTableView()
    super.viewDidLoad()
  }
  
  func registerNibs() {
    tableView.registerNib(RepositoryTableViewCell.self)
  }
  
  func setUpTableView() {
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
    
    tableView.rx.contentOffset
      .map { $0.y > self.tableView.contentSize.height - self.tableView.bounds.height - self.reloadBottomOffsetThreshold }
      .distinctUntilChanged()
      .filter { $0 && !viewModel.loading.value }
      .debug()
      .subscribe(onNext: { _ in
        viewModel.loadNextPage()
      })
      .disposed(by: bag)
  }
  
  var dataSource: RepositoriesDataSource {
    
    return RepositoriesDataSource(
      configureCell: {
        _, tableView, indexPath, model -> UITableViewCell in
        
        guard let cell = tableView
          .dequeueReusableCellWithDefaultIdentifier(
            RepositoryTableViewCell.self,
            for: indexPath
          ) else {
            return UITableViewCell()
        }
        
        cell.configure(model: model)
        
        return cell
      }
    )
  }
}
