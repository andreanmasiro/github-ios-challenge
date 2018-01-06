//
//  PullRequestServiceType.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 05/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import RxSwift

protocol PullRequestServiceType {
  
  var finishedLoading: PublishSubject<Void> { get }
  var pullRequests: Observable<[PullRequest]> { get }
}
