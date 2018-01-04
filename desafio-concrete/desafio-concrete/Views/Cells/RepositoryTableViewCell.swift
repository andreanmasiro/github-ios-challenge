//
//  RepositoryTableViewCell.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 04/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
  
  static var cellHeight: CGFloat {
    return 100.0
  }
  
  static var defaultNibName: String? {
    return "RepositoryTableViewCell"
  }
  
  static var defaultIdentifier: String? {
    return "RepositoryTableViewCell"
  }
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var branchCountLabel: UILabel!
  @IBOutlet weak var stargazerCountLabel: UILabel!
  
  @IBOutlet weak var userAvatarImageView: UIImageView!
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var userFullNameLabel: UILabel!
  
  @IBOutlet weak var branchImageView: UIImageView!
  @IBOutlet weak var stargazerImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setUpColors()
  }
  
  func setUpColors() {
    branchImageView.tintColor = UIColor.golden
    stargazerImageView.tintColor = UIColor.golden
    
    branchCountLabel.textColor = UIColor.golden
    stargazerCountLabel.textColor = UIColor.golden
    
    nameLabel.textColor = UIColor.oilBlue
    usernameLabel.textColor = UIColor.oilBlue
    
    userFullNameLabel.textColor = UIColor.lightGray
  }
}
