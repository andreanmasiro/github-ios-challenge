//
//  PullRequestTableViewCellSpec.swift
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

class PullRequestTableViewCellSpec: QuickSpec {
  
  override func spec() {
    
    describe("PullRequestTableViewCellSpec") {
      
      let cell = PullRequestTableViewCell.viewFromDefaultNib!
      
      context("after config") {
        
        it("should be prepared to display the correct information") {
          
          let pullRequest = PullRequest.fake()
          
          cell.config(model: pullRequest)
          
          expect(cell.titleLabel.text) == pullRequest.title
          expect(cell.descriptionLabel.text) == pullRequest.body
          expect(cell.authorUsernameLabel.text) == pullRequest.author.username
          expect(cell.createdAtLabel.text) == pullRequest.createdAt.humanReadableDescription
          expect(cell.authorAvatarImageView?.kf.webURL) == pullRequest.author.avatarURL
        }
      }
    }
  }
}
