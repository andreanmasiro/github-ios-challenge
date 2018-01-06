//
//  RepositorySpec.swift
//  desafio-concreteTests
//
//  Created by André Marques da Silva Rodrigues on 06/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Quick
import Nimble

@testable import desafio_concrete

class RepositorySpec: QuickSpec {
  
  override func spec() {
    
    describe("RepositorySpec") {
      
      context("when decoding from JSON") {
        
        let bundle = Bundle(for: RepositorySpec.self)
        let decoder = JSONDecoder.modelDecoder
        
        it("should succeed initializing from valid JSON") {
          
          let path = bundle.path(forResource: "Repository", ofType: "json")!
          let jsonData = NSData(contentsOfFile: path)! as Data
          
          expect { try decoder.decode(Repository.self, from: jsonData) }
            .notTo(throwError())
        }
        
        it("should fail initializing from invalid JSON") {
          
          let path = bundle.path(forResource: "Repository_invalid", ofType: "json")!
          let jsonData = NSData(contentsOfFile: path)! as Data
          
          expect { try decoder.decode(Repository.self, from: jsonData) }
            .to(throwError())
        }
        
        it("should succeed initializing from JSON with empty description") {
          
          let path = bundle.path(forResource: "Repository_nullDescription", ofType: "json")!
          let jsonData = NSData(contentsOfFile: path)! as Data
          
          expect { try decoder.decode(Repository.self, from: jsonData) }
            .notTo(throwError())
        }
        
        it("should fail when initializing from JSON with null pull requests URL") {
          
          let path = bundle.path(forResource: "Repository_invalidPullsURL", ofType: "json")!
          let jsonData = NSData(contentsOfFile: path)! as Data
          
          expect { try decoder.decode(Repository.self, from: jsonData) }
            .to(throwError(RepositoryDecodingError.invalidPullsURL))
        }
      }
    }
  }
}
