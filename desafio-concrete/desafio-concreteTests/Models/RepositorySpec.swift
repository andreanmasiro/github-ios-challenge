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
    
    describe("repository") {
      
      let bundle = Bundle(for: RepositorySpec.self)
      let decoder = JSONDecoder.modelDecoder
      
      it("should initialize correctly from JSON") {
        
        let path = bundle.path(forResource: "Repository", ofType: "json")!
        let jsonData = NSData(contentsOfFile: path)! as Data
        
        expect { try decoder.decode(Repository.self, from: jsonData) }
          .notTo(throwError())
      }
      
      it("should not initialize from invalid JSON") {
        
        let path = bundle.path(forResource: "Repository_invalid", ofType: "json")!
        let jsonData = NSData(contentsOfFile: path)! as Data
        
        expect { try decoder.decode(Repository.self, from: jsonData) }
          .to(throwError())
      }
      
      context("null description JSON") {
        
        it("should initialize correctly with empty description") {
          
          let path = bundle.path(forResource: "Repository_nullDescription", ofType: "json")!
          let jsonData = NSData(contentsOfFile: path)! as Data
          
          expect { try decoder.decode(Repository.self, from: jsonData) }
            .notTo(throwError())
        }
      }
      
      context("invalid pulls URL JSON") {
        
        it("should throw RepositoryDecodingError.invalidPullsURL") {
          
          let path = bundle.path(forResource: "Repository_invalidPullsURL", ofType: "json")!
          let jsonData = NSData(contentsOfFile: path)! as Data
          
          expect { try decoder.decode(Repository.self, from: jsonData) }
            .to(throwError(RepositoryDecodingError.invalidPullsURL))
        }
      }
    }
  }
}
