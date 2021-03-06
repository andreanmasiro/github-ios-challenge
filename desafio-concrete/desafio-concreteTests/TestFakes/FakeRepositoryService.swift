//
//  FakeRepositoryService.swift
//  desafio-concreteTests
//
//  Created by André Marques da Silva Rodrigues on 06/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import RxSwift

@testable import desafio_concrete

fileprivate var fakeError: Error?
struct FakeRepositoryService: RepositoryServiceType {
  
  private let page1: [Repository]
  private let emptyPage = [Repository]()
  
  init(bundle: Bundle) {
    
    fakeError = nil
    
    let page1Path = bundle.path(forResource: "RepositoryListPage", ofType: "json")!
    let jsonData = NSData.init(contentsOfFile: page1Path)! as Data
    
    let pageContainer = try! JSONDecoder.modelDecoder.decode(RepositoryListContainer.self, from: jsonData)
    
    self.page1 = pageContainer.items
  }
  
  let finishedLoading = PublishSubject<Void>()
  
  func repositories(page: Int) -> Observable<[Repository]> {
    
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
