//
//  PullRequestCellFactory.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 06/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import RxDataSources
import UIKit

typealias PullRequestsSection = AnimatableSectionModel<String, PullRequest>
typealias PullRequestsDataSource = RxTableViewSectionedAnimatedDataSource<PullRequestsSection>

struct PullRequestCellFactory {
  
  static var dataSource: PullRequestsDataSource {
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
