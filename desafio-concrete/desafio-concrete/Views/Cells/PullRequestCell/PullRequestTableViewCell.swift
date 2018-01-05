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
  @IBOutlet weak var authorFullNameLabel: UILabel!
  @IBOutlet weak var authorAvatarImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setUpColors()
    setUpImageView()
    authorAvatarImageView.setRound(true)
  }
  
  func setUpColors() {
    
    titleLabel.textColor = UIColor.oilBlue
    authorUsernameLabel.textColor = UIColor.oilBlue
    
    authorFullNameLabel.textColor = UIColor.lightGray
  }
  
  func setUpImageView() {
    authorAvatarImageView.kf.indicatorType = .activity
  }
  
  func config(model: PullRequestListCellModel) {
    
    guard case let .pullRequest(
      _,
      title,
      description,
      authorUsername,
      authorFullname,
      authorAvatarURL
      ) = model else { return }
    
    titleLabel.text = title
    descriptionLabel.text = description
    authorUsernameLabel.text = authorUsername
    authorFullNameLabel.text = authorFullname

    authorAvatarImageView.kf.setImage(with: authorAvatarURL, placeholder: #imageLiteral(resourceName: "default_avatar_icon"))
  }
  
  override func prepareForReuse() {
    authorAvatarImageView.kf.cancelDownloadTask()
    super.prepareForReuse()
  }
}
