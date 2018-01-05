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
  var dataSource: RepositoriesDataSource!
  let bag = DisposeBag()
  let tableViewDelegate = RepositoryTableViewDelegate()
  
  override func viewDidLoad() {
    
    registerNibs()
    configDataSource()
    bindUI()
    
    super.viewDidLoad()
  }
  
  func registerNibs() {
    tableView.registerNib(RepositoryTableViewCell.self)
  }
  
  func bindUI() {
    
    let viewModel = RepositoryListViewModel()
    
    viewModel.sectionedRepositories
      .drive(tableView.rx.items(dataSource: dataSource))
      .disposed(by: bag)
    
    tableView.rx.setDelegate(tableViewDelegate)
      .disposed(by: bag)
  }
  
  func configDataSource() {
    
    dataSource = RepositoriesDataSource(
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
