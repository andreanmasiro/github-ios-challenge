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
  private let perPage = 30
  private let bag = DisposeBag()
  
  let finishedLoading = PublishSubject<Void>()
  
  init(apiURL: URL) {
    self.apiURL = apiURL
  }
  
  func pullRequests(page: Int) -> Observable<[PullRequest]> {
    
    let params = APIParams.params(page: page, perPage: perPage)
    
    return RxAlamofire
      .requestData(.get, apiURL, parameters: params, encoding: URLEncoding.queryString, headers: nil)
      .map { response, json -> [PullRequest] in
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let list = try decoder.decode([PullRequest].self, from: json)
        return list
      }
      .do(onNext: {
        if $0.count < self.perPage {
          self.finishedLoading.onNext(())
          self.finishedLoading.onCompleted()
        }
      })
  }
}
