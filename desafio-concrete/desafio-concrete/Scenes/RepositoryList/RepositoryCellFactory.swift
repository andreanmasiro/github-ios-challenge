//
//  RepositoryCellFactory.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 06/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import RxDataSources
import UIKit

typealias RepositoriesDataSource = RxTableViewSectionedAnimatedDataSource<RepositoriesSection>

struct RepositoryCellFactory {
  
  static var dataSource: RepositoriesDataSource {
    
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
