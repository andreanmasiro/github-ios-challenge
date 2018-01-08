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
      
      context("when decoding from JSON") {
        
        let bundle = Bundle(for: PullRequestSpec.self)
        let decoder = JSONDecoder.modelDecoder
        
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
      
      context("when comparing") {
        
        it("should compare the id property") {
          
          let pull0 = PullRequest.fake(id: 0)
          let pull1 = PullRequest.fake(id: 1)
          
          expect(pull0 == pull1) == false
          expect(pull0 == pull0) == true
        }
      }
      
      describe("identifiable") {
        
        it("should return the id property") {
          
          let repo = Repository.fake()
          
          expect(repo.identity) == repo.id
        }
      }
    }
  }
}
