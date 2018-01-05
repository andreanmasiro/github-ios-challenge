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
  let bag = DisposeBag()
  let tableViewDelegate = PullRequestListTableViewDelegate()
  
  override func viewDidLoad() {
    
    registerNibs()
    bindUI()
    super.viewDidLoad()
  }
  
  func bindUI() {
    
//    let viewModel = PullRequestListViewModel(repository: )
    
//    let dataSource = self.dataSource
//
//    tableViewDelegate.headerModels = viewModel.headerModels sort of
//    tableView.rx.setDelegate(tableViewDelegate)
//      .disposed(by: bag)
//    
//    viewModel.sectionedPullRequests
//      .drive(tableView.rx.items(dataSource: dataSource))
//      .disposed(by: bag)
//    
//    viewModel.repository.asDriver()
//      .map { $0.name }
//      .drive(navigationItem.rx.title)
//      .disposed(by: bag)
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
