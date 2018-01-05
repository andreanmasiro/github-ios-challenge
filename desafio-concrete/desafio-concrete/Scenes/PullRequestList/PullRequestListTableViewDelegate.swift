//
//  PullRequestListTableViewDelegate.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 05/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit
import RxSwift

class PullRequestListTableViewDelegate: NSObject, UITableViewDelegate {
  
  var headerModels = Variable<[PullRequestHeaderModel]>([])
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return PullRequestTableViewCell.cellHeight
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return PullRequestHeaderTableViewCell.cellHeight
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    let sectionHeaderModel = headerModels.value[section]
    
    guard let header = tableView.dequeueReusableCellWithDefaultIdentifier(
          PullRequestHeaderTableViewCell.self
      ) else {
      return nil
    }
    
    header.config(model: sectionHeaderModel)
    
    return header
  }
}
