//
//  RepositoryTableViewCell.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 04/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit
import Kingfisher

class RepositoryTableViewCell: UITableViewCell {
  
  static var cellHeight: CGFloat {
    return 100.0
  }
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var forksCountLabel: UILabel!
  @IBOutlet weak var stargazersCountLabel: UILabel!
  
  @IBOutlet weak var userAvatarImageView: UIImageView!
  @IBOutlet weak var usernameLabel: UILabel!
  
  @IBOutlet weak var forkImageView: UIImageView!
  @IBOutlet weak var stargazerImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setUpColors()
    setUpImageView()
    userAvatarImageView.setRound(true)
  }
  
  func setUpImageView() {
    userAvatarImageView.kf.indicatorType = .activity
  }
  
  func setUpColors() {
    forkImageView.tintColor = UIColor.golden
    stargazerImageView.tintColor = UIColor.golden
    
    forksCountLabel.textColor = UIColor.golden
    stargazersCountLabel.textColor = UIColor.golden
    
    nameLabel.textColor = UIColor.oilBlue
    usernameLabel.textColor = UIColor.oilBlue
  }
  
  func config(model: Repository) {
    
      nameLabel.text = model.name
      descriptionLabel.text = model.description
      forksCountLabel.text = String(model.forksCount)
      stargazersCountLabel.text = String(model.stargazersCount)
      
      usernameLabel.text = model.owner.username
      
      userAvatarImageView.kf.setImage(with: model.owner.avatarURL, placeholder: #imageLiteral(resourceName: "default_avatar_icon"))
  }
  
  override func prepareForReuse() {
    userAvatarImageView.kf.cancelDownloadTask()
    super.prepareForReuse()
  }
}
