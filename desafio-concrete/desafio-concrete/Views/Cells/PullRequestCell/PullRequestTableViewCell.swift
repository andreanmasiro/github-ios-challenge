//
//  PullRequestTableViewCell.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 05/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit

class PullRequestTableViewCell: UITableViewCell {
  
  static var cellHeight: CGFloat {
    return 120.0
  }
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var authorUsernameLabel: UILabel!
  @IBOutlet weak var authorFullNameLabel: UILabel!
  @IBOutlet weak var authorAvatarImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setUpColors()
    authorAvatarImageView.setRound(true)
  }
  
  func setUpColors() {
    
    titleLabel.textColor = UIColor.oilBlue
    authorUsernameLabel.textColor = UIColor.oilBlue
    
    authorFullNameLabel.textColor = UIColor.lightGray
  }
}
