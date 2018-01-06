//
//  PullRequestSpec.swift
//  desafio-concreteTests
//
//  Created by André Marques da Silva Rodrigues on 06/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Quick
import Nimble

@testable import desafio_concrete

class PullRequestSpec: QuickSpec {

  override func spec() {
    
    describe("pull request") {
      
      let bundle = Bundle(for: PullRequestSpec.self)
      let decoder = JSONDecoder.modelDecoder
      it("should initialize correctly from JSON") {
        
        let path = bundle.path(forResource: "PullRequest", ofType: "json")!
        let jsonData = NSData(contentsOfFile: path)! as Data
        
        expect { try decoder.decode(PullRequest.self, from: jsonData) }
          .notTo(throwError())
      }
      
      it("should not initialize from invalid JSON") {
        
        let path = bundle.path(forResource: "PullRequest_invalid", ofType: "json")!
        let jsonData = NSData(contentsOfFile: path)! as Data
        
        expect { try decoder.decode(PullRequest.self, from: jsonData) }
          .to(throwError())
      }
      
      context("null body JSON") {
        
        it("should initialize correctly with empty body") {
          
          let path = bundle.path(forResource: "PullRequest_nullBody", ofType: "json")!
          let jsonData = NSData(contentsOfFile: path)! as Data
          
          expect { try decoder.decode(PullRequest.self, from: jsonData) }
            .notTo(throwError())
        }
      }
    }
  }
}
