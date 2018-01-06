//
//  RepositoryServiceType.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 05/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import RxSwift

protocol RepositoryServiceType {
  
  var repositories: BehaviorSubject<[Repository]> { get }
  var finishedLoading: PublishSubject<Void> { get }
  
  func loadRepositoryList(page: Int)
}
