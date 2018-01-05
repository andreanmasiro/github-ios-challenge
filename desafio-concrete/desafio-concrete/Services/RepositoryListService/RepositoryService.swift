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

enum RepositoryServiceError: Error {
  case invalidURLPath(String)
}

struct RepositoryService: RepositoryServiceType {

  private let apiPath = "https://api.github.com/search/repositories?q=language:Java&sort=stars&page="
  
  func getRepositoryList(page: Int) -> Observable<[Repository]> {
    
    let path = apiPath + "\(page)"
    guard let url = URL(string: path) else {
      return Observable.error(RepositoryServiceError.invalidURLPath(path))
    }
    
    return RxAlamofire
      .requestData(.get, url)
      .map { response, json -> [Repository] in
        
        let decoder = JSONDecoder()
        let list = try decoder.decode(RepositoryListHelper.self, from: json)
        return list.items
      }
  }
}
