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

  private let apiPath: String
  
  init(apiPath: String) {
    self.apiPath = apiPath
  }
  
  func getRepositoryList(page: Int) -> Observable<[Repository]> {
    
    guard let url = URL(string: apiPath + "&page=\(page)") else {
      return Observable.error(RepositoryServiceError.invalidURLPath(apiPath))
    }
//    let params = ["page": page]
    
    return RxAlamofire
      .requestData(.get, url)
      .map { response, json -> [Repository] in
        
        let decoder = JSONDecoder()
        let list = try decoder.decode(RepositoryListHelper.self, from: json)
        return list.items
      }
  }
}
