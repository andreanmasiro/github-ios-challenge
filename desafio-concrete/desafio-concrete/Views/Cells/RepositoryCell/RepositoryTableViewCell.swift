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
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var branchCountLabel: UILabel!
  @IBOutlet weak var stargazersCountLabel: UILabel!
  
  @IBOutlet weak var userAvatarImageView: UIImageView!
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var userFullNameLabel: UILabel!
  
  @IBOutlet weak var branchImageView: UIImageView!
  @IBOutlet weak var stargazerImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setUpColors()
    userAvatarImageView.setRound(true)
  }
  
  func configure(model: RepositoryListCellModel) {
    
    if case let .repository(
      _,
      name,
      description,
      branchCount,
      stargazersCount,
      ownerUsername,
      ownerFullName
      ) = model {
      
      nameLabel.text = name
      descriptionLabel.text = description
      branchCountLabel.text = String(branchCount)
      stargazersCountLabel.text = String(stargazersCount)
      
      usernameLabel.text = ownerUsername
      userFullNameLabel.text = ownerFullName
    }
  }
  
  func setUpColors() {
    branchImageView.tintColor = UIColor.golden
    stargazerImageView.tintColor = UIColor.golden
    
    branchCountLabel.textColor = UIColor.golden
    stargazersCountLabel.textColor = UIColor.golden
    
    nameLabel.textColor = UIColor.oilBlue
    usernameLabel.textColor = UIColor.oilBlue
    
    userFullNameLabel.textColor = UIColor.lightGray
  }
}
