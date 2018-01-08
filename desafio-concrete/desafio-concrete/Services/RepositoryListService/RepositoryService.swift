//
//  RepositoryService.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 05/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import RxSwift
import Alamofire
import RxAlamofire
import RxCocoa

enum RepositoryServiceError: Error {
  case invalidAPIPath
  case rateLimitExceeded(refreshTime: TimeInterval)
  case unknown
}

struct RepositoryService: RepositoryServiceType {
  
  private let apiPath: String
  private let perPage = 30
  private let bag = DisposeBag()

  let finishedLoading = PublishSubject<Void>()
  
  init(apiPath: String) {
    self.apiPath = apiPath
  }
  
  private func retryHandler(errorObservable: Observable<Error>) -> Observable<Void> {
    return errorObservable.flatMap { error -> Observable<Void> in
      
      guard case let RepositoryServiceError
        .rateLimitExceeded(refreshTime) = error else {
          return Observable.error(error)
      }
      let nowTimeStamp = Date().timeIntervalSince1970
      let dueStamp = refreshTime - nowTimeStamp
      
      return Observable<Int>
        .timer(max(0, dueStamp),
               period: nil,
               scheduler: MainScheduler.instance)
        .map { _ in }
    }
  }
  
  func repositories(page: Int) -> Observable<[Repository]> {
    
    guard let url = URL(string: apiPath) else {
      return .error(RepositoryServiceError.invalidAPIPath)
    }
    
    let params = APIParams.params(page: page, perPage: perPage)
    
    return RxAlamofire
      .requestData(.get, url, parameters: params, encoding: URLEncoding.queryString, headers: nil)
      .map { response, json -> [Repository] in
        
        switch response.statusCode {
        case 200..<300:
          
          let decoder = JSONDecoder()
          let listContainer = try decoder.decode(RepositoryListContainer.self, from: json)
          return listContainer.items
          
        case 403:
          
          guard let refreshTimeString = response.allHeaderFields[APIKeys.rateLimitResetHeaderKey] as? String,
            let refreshTime = TimeInterval(refreshTimeString) else {
            throw RepositoryServiceError.unknown
          }
          throw RepositoryServiceError
            .rateLimitExceeded(refreshTime: refreshTime)
          
        default: throw RepositoryServiceError.unknown
        }
      }
      .retryWhen(retryHandler)
      .do(onNext: { newRepos in
        if newRepos.count < self.perPage {
          self.finishedLoading.onNext(())
          self.finishedLoading.onCompleted()
        }
      })
  }
}
