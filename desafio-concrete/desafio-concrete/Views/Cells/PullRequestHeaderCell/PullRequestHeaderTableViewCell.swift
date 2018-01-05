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
  
  func config(model: PullRequestHeaderModel) {
    
    let openText = "\(model.openCount) open "
    let closedText = "/ \(model.closedCount) closed"
    
    let text = NSMutableAttributedString(string: openText + closedText)
    
    let goldenRange = NSRange.init(location: 0, length: openText.count)
    let blackRange = NSRange.init(location: openText.count, length: closedText.count)
    
    text.addAttribute(.foregroundColor, value: UIColor.golden, range: goldenRange)
    text.addAttribute(.foregroundColor, value: UIColor.black, range: blackRange)
    
    statusLabel.attributedText = text
  }
}
