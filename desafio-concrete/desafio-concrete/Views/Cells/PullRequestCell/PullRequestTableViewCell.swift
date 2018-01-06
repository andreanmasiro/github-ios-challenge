//
//  PullRequestTableViewCell.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 05/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit
import Kingfisher

class PullRequestTableViewCell: UITableViewCell {
  
  static var cellHeight: CGFloat {
    return 130.0
  }
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var authorUsernameLabel: UILabel!
  @IBOutlet weak var authorAvatarImageView: UIImageView!
  @IBOutlet weak var createdAtLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setUpColors()
    setUpImageView()
    authorAvatarImageView.setRound(true)
  }
  
  func setUpColors() {
    
    titleLabel.textColor = UIColor.oilBlue
    authorUsernameLabel.textColor = UIColor.oilBlue
  }
  
  func setUpImageView() {
    authorAvatarImageView.kf.indicatorType = .activity
  }
  
  func config(model: PullRequest) {
    
    titleLabel.text = model.title
    descriptionLabel.text = model.body
    authorUsernameLabel.text = model.author.username
    createdAtLabel.text = model.createdAt.humanReadableDescription

    authorAvatarImageView.kf.setImage(with: model.author.avatarURL, placeholder: #imageLiteral(resourceName: "default_avatar_icon"))
  }
  
  override func prepareForReuse() {
    authorAvatarImageView.kf.cancelDownloadTask()
    super.prepareForReuse()
  }
}
