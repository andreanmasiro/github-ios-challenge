//
//  RepositoryServiceSpec.swift
//  desafio-concreteTests
//
//  Created by André Marques da Silva Rodrigues on 06/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs
import RxBlocking
import RxSwift

@testable import desafio_concrete

class RepositoryServiceSpec: QuickSpec {
  
  override func spec() {
    
    describe("RepositoryServiceSpec") {
      
      context("when fetching repositories") {
        
        let bundle = Bundle(for: RepositoryServiceSpec.self)
        
        var disposeBag: DisposeBag!
        
        beforeEach {
          disposeBag = DisposeBag()
        }
        
        context("with valid api path") {
        
          let host = "fakeapilink.com"
          let fakeApiPath = "https://\(host)/"
          let service = RepositoryService(apiPath: fakeApiPath)
          
          it("should parse the repositories correctly from a not-empty page") {
            
            stub(condition: isHost(host), response: { (request) -> OHHTTPStubsResponse in
              
              let fixturePath = bundle.path(forResource: "RepositoryListPage", ofType: "json")!
              return fixture(filePath: fixturePath, status: 200, headers: nil)
            })
            
            var repos: [Repository]?
            
            service.repositories(page: 1)
              .subscribe(onNext: {
                repos = $0
              })
              .disposed(by: disposeBag)
            
            expect(repos).toEventuallyNot(beEmpty())
          }
          
          it("should parse empty repositories correctly from an empty page") {
            
            stub(condition: isHost(host), response: { (request) -> OHHTTPStubsResponse in
              
              let fixturePath = bundle.path(forResource: "RepositoryListPage_empty", ofType: "json")!
              return fixture(filePath: fixturePath, status: 200, headers: nil)
            })
            
            var repos: [Repository]?
            
            service.repositories(page: 1)
              .subscribe(onNext: {
                repos = $0
              })
              .disposed(by: disposeBag)
            
            expect(repos).toEventually(beEmpty())
          }
        }
        
        context("with invalid api path") {
          
          it("should fail fetching repositories due to invalid API path") {
           
            let invalidApiPath = ""
            let service = RepositoryService(apiPath: invalidApiPath)
            
            var error: Error?
            
            service.repositories(page: 1)
              .subscribe(onError: {
                error = $0
              })
              .disposed(by: disposeBag)
            
            expect(error).toEventually(matchError(RepositoryServiceError.invalidAPIPath))
          }
        }
      }
    }
  }
}
