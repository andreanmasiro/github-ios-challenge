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
  private let gatheringPullRequests = Variable<[PullRequest]>([])
  private let bag = DisposeBag()
  
  let pullRequests: BehaviorSubject<[PullRequest]>
  
  init(apiURL: URL) {
    self.apiURL = apiURL
    
    pullRequests = BehaviorSubject<[PullRequest]>(value: gatheringPullRequests.value)
    
    gatheringPullRequests.asObservable()
      .bind(to: pullRequests)
      .disposed(by: bag)
  }
  
  func loadPullRequestList(page: Int) {
    
    RxAlamofire
      .requestData(.get, apiURL, parameters: ["page": page], encoding: URLEncoding.queryString, headers: nil)
      .map { response, json -> [PullRequest] in
        
        let decoder = JSONDecoder()
        let list = try decoder.decode([PullRequest].self, from: json)
        return list
      }
      .do(onNext: { newPulls in
        self.gatheringPullRequests.value.append(contentsOf: newPulls)
      })
      .subscribe()
      .disposed(by: bag)
  }
}
