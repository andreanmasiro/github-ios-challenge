//
//  PullRequestHeaderView.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 06/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit

class PullRequestHeaderView: UIView, NibLoadableView {

  @IBOutlet weak var view: UIView!
  @IBOutlet weak var statusLabel: UILabel!
  
  override func awakeFromNib() {
    
    if Bundle.main.loadNibNamed(PullRequestHeaderView.defaultNibName, owner: self, options: nil) != nil {
      view.frame = bounds
      addSubview(view)
    }
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
