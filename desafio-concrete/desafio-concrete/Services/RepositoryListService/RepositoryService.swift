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
  case invalidURLPath(String)
}

struct RepositoryService: RepositoryServiceType {
  
  private let apiPath: String
  private let bag = DisposeBag()
  
  let finishedLoading = PublishSubject<Void>()
  
  init(apiPath: String) {
    self.apiPath = apiPath
  }
  
  func repositories(page: Int) -> Observable<[Repository]> {
    
    guard let url = URL(string: apiPath) else {
      return .empty()
    }
    
    return RxAlamofire
      .requestData(.get, url, parameters: ["page": page], encoding: URLEncoding.queryString, headers: nil)
      .map { response, json -> [Repository] in
        
        let decoder = JSONDecoder()
        let list = try decoder.decode(RepositoryListHelper.self, from: json)
        return list.items
      }
      .do(onNext: { newRepos in
        if newRepos.isEmpty {
          self.finishedLoading.onNext(())
          self.finishedLoading.onCompleted()
        }
      })
  }
}
