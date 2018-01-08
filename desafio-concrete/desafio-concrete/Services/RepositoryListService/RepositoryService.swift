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
  case timeout
  case unknown
  
  var localizedDescription: String {
    
    switch self {
    case .invalidAPIPath: return "Invalid API Path."
    case .rateLimitExceeded(let refreshTime): return "Rate limit exceeded. Try again in \(refreshTime) seconds."
    case .timeout: return "The request timed out."
    case .unknown: return "Unknown error."
    }
  }
}

struct RepositoryService: RepositoryServiceType {
  
  private let apiPath: String
  private let perPage = 30
  private let bag = DisposeBag()

  let finishedLoading = PublishSubject<Void>()
  let loadingError: Observable<RepositoryServiceError>
  private let loadingErrorSubject = PublishSubject<RepositoryServiceError>()
  
  init(apiPath: String) {
    
    self.apiPath = apiPath
    loadingError = loadingErrorSubject.asObservable()
  }
  
  private func retryHandler(errorObservable: Observable<Error>) -> Observable<Void> {
    return errorObservable.flatMap { error -> Observable<Void> in
      
      guard case let RepositoryServiceError
        .rateLimitExceeded(refreshTime) = error else {
          throw error
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
    
    loadingErrorSubject.onNext(RepositoryServiceError.timeout)
    guard let url = URL(string: apiPath) else {
      return .error(RepositoryServiceError.invalidAPIPath)
    }
    
    let params = APIParams.params(page: page, perPage: perPage)
    
    return RxAlamofire
      .requestData(.get, url, parameters: params, encoding: URLEncoding.queryString, headers: nil)
      .map { response, json -> [Repository] in
        
        switch response.statusCode {
        case 200..<300:
          
          let decoder = JSONDecoder.modelDecoder
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
      .catchError { error in
        
        if case RepositoryServiceError.rateLimitExceeded = error {
          
          throw error
        } else {
          
          let error = error as NSError
          if error.code == -1001 {
            self.loadingErrorSubject.onNext(RepositoryServiceError.timeout)
          } else {
            self.loadingErrorSubject.onNext(RepositoryServiceError.unknown)
          }
          return .just([])
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
