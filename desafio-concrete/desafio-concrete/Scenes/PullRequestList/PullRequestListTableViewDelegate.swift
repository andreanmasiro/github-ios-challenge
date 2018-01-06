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
  private let bag = DisposeBag()
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return PullRequestHeaderTableViewCell.cellHeight
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    guard let header = tableView.dequeueReusableCellWithDefaultIdentifier(
          PullRequestHeaderTableViewCell.self
      ) else {
      return nil
    }
    
    headerModels.asDriver()
      .drive(onNext: {
        header.config(model: $0[section])
      })
      .disposed(by: bag)
    
    return header
  }
}
