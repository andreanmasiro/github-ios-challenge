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
  var dataSource: PullRequestsDataSource! {
    didSet {
      tableViewDelegate = PullRequestListTableViewDelegate(dataSource: dataSource)
    }
  }
  let bag = DisposeBag()
  var tableViewDelegate: PullRequestListTableViewDelegate!
  
  override func viewDidLoad() {
    
    registerNibs()
    configDataSource()
    bindUI()
    super.viewDidLoad()
  }
  
  func bindUI() {
    
    let viewModel = PullRequestListViewModel()
    
    tableView.rx.setDelegate(tableViewDelegate)
      .disposed(by: bag)
    
    viewModel.sectionedPullRequests
      .drive(tableView.rx.items(dataSource: dataSource))
      .disposed(by: bag)
  }
  
  func registerNibs() {
    
    tableView.registerNib(PullRequestHeaderTableViewCell.self)
    tableView.registerNib(PullRequestTableViewCell.self)
  }
  
  func configDataSource() {
    
    dataSource = PullRequestsDataSource(
      configureCell: {
        (_, tableView, indexPath, model) -> UITableViewCell in
        
        guard let cell = tableView
          .dequeueReusableCellWithDefaultIdentifier(
            PullRequestTableViewCell.self,
            for: indexPath
          ) else {
            return UITableViewCell()
        }
        
        if case .pullRequest = model {
          cell.config(model: model)
        }
        
        return cell
      }
    )
  }
  
}
