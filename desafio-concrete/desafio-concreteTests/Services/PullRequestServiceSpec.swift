//
//  PullRequestServiceSpec.swift
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

class PullRequestServiceSpec: QuickSpec {
  
  override func spec() {
    
    describe("RepositoryServiceSpec") {
      
      context("when fetching repositories") {
        
        let bundle = Bundle(for: PullRequestServiceSpec.self)
        
        var disposeBag: DisposeBag!
        
        beforeEach {
          disposeBag = DisposeBag()
        }
        
        let host = "fakeapilink.com"
        let fakeApiPath = "https://\(host)/"
        let fakeURL = URL(string: fakeApiPath)!
        let service = PullRequestService(apiURL: fakeURL)
        
        it("should parse the pull requests correctly from a not-empty page") {
          
          stub(condition: isHost(host), response: { (request) -> OHHTTPStubsResponse in
            
            let fixturePath = bundle.path(forResource: "PullRequestListPage", ofType: "json")!
            return fixture(filePath: fixturePath, status: 200, headers: nil)
          })
          
          var pulls: [PullRequest]?
          
          service.pullRequests(page: 1)
            .subscribe(onNext: {
              pulls = $0
            })
            .disposed(by: disposeBag)
          
          expect(pulls).toEventuallyNot(beEmpty())
        }
        
        it("should parse empty pull requests correctly from an empty page") {
          
          stub(condition: isHost(host), response: { (request) -> OHHTTPStubsResponse in
            
            let fixturePath = bundle.path(forResource: "PullRequestListPage_empty", ofType: "json")!
            return fixture(filePath: fixturePath, status: 200, headers: nil)
          })
          
          var pulls: [PullRequest]?
          
          service.pullRequests(page: 1)
            .subscribe(onNext: {
              pulls = $0
            })
            .disposed(by: disposeBag)
          
          expect(pulls).toEventually(beEmpty())
        }
        
        it("should fail fetching pull requests due to invalid JSON") {
          
          stub(condition: isHost(host), response: { (request) -> OHHTTPStubsResponse in
            
            let fixturePath = bundle.path(forResource: "PullRequestListPage_invalid", ofType: "json")!
            return fixture(filePath: fixturePath, status: 200, headers: nil)
          })
          
          var error: Error?
          
          service.pullRequests(page: 1)
            .subscribe(onError: {
              error = $0
            })
            .disposed(by: disposeBag)
          
          expect(error).toEventuallyNot(beNil())
        }
      }
    }
  }
}
