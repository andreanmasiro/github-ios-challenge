//
//  PullRequestListTableViewDelegate.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 05/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit
import RxDataSources

class PullRequestListTableViewDelegate: NSObject, UITableViewDelegate {
  
  unowned var dataSource: PullRequestsDataSource
  
  init(dataSource: PullRequestsDataSource) {
    self.dataSource = dataSource
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return PullRequestTableViewCell.cellHeight
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return PullRequestHeaderTableViewCell.cellHeight
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    let sectionHeaderModel = dataSource.sectionModels[0].model
    
    guard case .pullRequestHeader = sectionHeaderModel,
      let header = tableView.dequeueReusableCellWithDefaultIdentifier(
          PullRequestHeaderTableViewCell.self
      ) else {
      return nil
    }
    
    header.config(model: sectionHeaderModel)
    
    return header
  }
}
