//
//  FakePullRequestService.swift
//  desafio-concreteTests
//
//  Created by André Marques da Silva Rodrigues on 06/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import RxSwift

@testable import desafio_concrete

fileprivate var fakeError: Error?
struct FakePullRequestService: PullRequestServiceType {
  
  private let page1: [PullRequest]
  private let emptyPage = [PullRequest]()
  let finishedLoading = PublishSubject<Void>()
  
  init(bundle: Bundle) {
    
    fakeError = nil
    
    let page1Path = bundle.path(forResource: "PullRequestListPage", ofType: "json")!
    let jsonData = NSData.init(contentsOfFile: page1Path)! as Data
    
    self.page1 = try! JSONDecoder.modelDecoder.decode([PullRequest].self, from: jsonData)
  }
  
  func pullRequests(page: Int) -> Observable<[PullRequest]> {
    if let error = fakeError {
      return .error(error)
    } else {
      return Observable.just((page == 1 ? self.page1 : self.emptyPage))
        .do(onNext: {
          if $0.isEmpty {
            self.finishedLoading.onNext(())
            self.finishedLoading.onCompleted()
          }
        })
    }
  }
  
  func setError(_ error: Error?) {
    return fakeError = error
  }
}
