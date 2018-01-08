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
    loadNib()
    setUpColors()
  }
  
  func loadNib() {
    
    let nibName = PullRequestHeaderView.defaultNibName
    if Bundle.main.loadNibNamed(nibName, owner: self, options: nil) != nil {
      
      addSubview(view)
    }
  }
  
  func setUpColors() {
    statusLabel.textColor = UIColor.golden
  }
  
  func config(count: Int) {
    let text = count == 0 ? "No pull requests" : "\(count) open"
    statusLabel.text = text
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    view.frame = bounds
  }
}
