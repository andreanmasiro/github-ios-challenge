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
    
    if Bundle.main.loadNibNamed(PullRequestHeaderView.defaultNibName, owner: self, options: nil) != nil {
    
      view.frame = bounds
      addSubview(view)
    }
  }
  
  func setUpColors() {
    statusLabel.textColor = UIColor.golden
  }
  
  func config(count: Int) {
    
    statusLabel.text = "\(count) open"
  }
}
