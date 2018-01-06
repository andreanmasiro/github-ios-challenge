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
    
    describe("PullRequestSpec") {
      
      let bundle = Bundle(for: PullRequestSpec.self)
      let decoder = JSONDecoder.modelDecoder
      
      context("when decoding from JSON") {
        
        it("should suceed initializing from valid JSON") {
          
          let path = bundle.path(forResource: "PullRequest", ofType: "json")!
          let jsonData = NSData(contentsOfFile: path)! as Data
          
          expect { try decoder.decode(PullRequest.self, from: jsonData) }
            .notTo(throwError())
        }
        
        it("should fail initializing from invalid JSON") {
          
          let path = bundle.path(forResource: "PullRequest_invalid", ofType: "json")!
          let jsonData = NSData(contentsOfFile: path)! as Data
          
          expect { try decoder.decode(PullRequest.self, from: jsonData) }
            .to(throwError())
        }
        
        it("should suceed initializing from JSON with empty body") {
          
          let path = bundle.path(forResource: "PullRequest_nullBody", ofType: "json")!
          let jsonData = NSData(contentsOfFile: path)! as Data
          
          expect { try decoder.decode(PullRequest.self, from: jsonData) }
            .notTo(throwError())
        }
      }
    }
  }
}
