//
//  PullRequestHeaderTableViewCell.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 05/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit

class PullRequestHeaderTableViewCell: UITableViewCell {
  
  static var cellHeight: CGFloat {
    return 35.0
  }
  
  @IBOutlet weak var statusLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func config(model: PullRequestListCellModel) {
    
    guard case let .pullRequestHeader(closedCount, openCount) = model else {
      return
    }
    
    // config with attributed text
  }
}
