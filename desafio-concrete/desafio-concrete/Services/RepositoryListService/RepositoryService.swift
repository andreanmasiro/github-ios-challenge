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
  private let gatheringRepositories = Variable<[Repository]>([])
  private let bag = DisposeBag()
  
  let repositories: BehaviorSubject<[Repository]>
  
  init(apiPath: String) {
    self.apiPath = apiPath
    
    repositories = BehaviorSubject<[Repository]>(value: gatheringRepositories.value)
    
    gatheringRepositories.asObservable()
      .bind(to: repositories)
      .disposed(by: bag)
  }
  
  func loadRepositoryList(page: Int) {
    
    guard let url = URL(string: apiPath) else {
      return
    }
    
    RxAlamofire
      .requestData(.get, url, parameters: ["page": page], encoding: URLEncoding.queryString, headers: nil)
      .map { response, json -> [Repository] in
        
        let decoder = JSONDecoder()
        let list = try decoder.decode(RepositoryListHelper.self, from: json)
        return list.items
      }
      .do(onNext: { newRepos in
        self.gatheringRepositories.value.append(contentsOf: newRepos)
      })
      .subscribe()
      .disposed(by: bag)
  }
}
