//
//  PullRequestService.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 05/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import RxSwift
import Alamofire
import RxAlamofire
import RxCocoa

struct PullRequestService: PullRequestServiceType {
  
  private let apiURL: URL
  private let bag = DisposeBag()
  
  let finishedLoading = PublishSubject<Void>()
  
  init(apiURL: URL) {
    self.apiURL = apiURL
  }
  
  func pullRequests(page: Int) -> Observable<[PullRequest]> {
    
    return RxAlamofire
      .requestData(.get, apiURL, parameters: ["page": page], encoding: URLEncoding.queryString, headers: nil)
      .map { response, json -> [PullRequest] in
        
        let decoder = JSONDecoder()
        let list = try decoder.decode([PullRequest].self, from: json)
        return list
      }
      .do(onNext: {
        if $0.isEmpty {
          self.finishedLoading.onCompleted()
        }
      })
  }
}
