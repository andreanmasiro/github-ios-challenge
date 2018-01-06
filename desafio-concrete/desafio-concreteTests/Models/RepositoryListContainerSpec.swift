//
//  RepositoryListContainerSpec.swift
//  desafio-concreteTests
//
//  Created by André Marques da Silva Rodrigues on 06/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Quick
import Nimble

@testable import desafio_concrete

class RepositoryListContainerSpec: QuickSpec {

  override func spec() {
    
    describe("repositoryListContainer") {
      
      let bundle = Bundle(for: RepositoryListContainerSpec.self)
      let decoder = JSONDecoder.modelDecoder
      
      it("should initialize correctly from JSON") {
        
        let path = bundle.path(forResource: "RepositoryListPage", ofType: "json")!
        let jsonData = NSData(contentsOfFile: path)! as Data
        
        expect { try decoder.decode(RepositoryListContainer.self, from: jsonData) }
          .notTo(throwError())
      }
      
      it("should not initialize from invalid JSON") {
        
        let path = bundle.path(forResource: "RepositoryListPage_invalid", ofType: "json")!
        let jsonData = NSData(contentsOfFile: path)! as Data
        
        expect { try decoder.decode(RepositoryListContainer.self, from: jsonData) }
          .to(throwError())
      }
    }
  }
}
