//
//  RepositoryTableViewCellSpec.swift
//  desafio-concreteTests
//
//  Created by André Marques da Silva Rodrigues on 07/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit
import Quick
import Nimble
import Kingfisher
import OHHTTPStubs

@testable import desafio_concrete

class RepositoryTableViewCellSpec: QuickSpec {

  override func spec() {
    
    describe("RepositoryTableViewCellSpec") {
      
      let cell = RepositoryTableViewCell.viewFromDefaultNib!
      
      context("after config") {
        
        it("should be prepared to display the correct information") {

          let repository = Repository.fake
          
          cell.config(model: repository)

          expect(cell.nameLabel.text) == repository.name
          expect(cell.descriptionLabel.text) == repository.description
          expect(cell.forksCountLabel.text) == String(repository.forksCount)
          expect(cell.stargazersCountLabel.text) == String(repository.stargazersCount)
          expect(cell.usernameLabel.text) == repository.owner.username
          expect(cell.userAvatarImageView?.kf.webURL) == repository.owner.avatarURL
        }
      }
    }
  }
}
