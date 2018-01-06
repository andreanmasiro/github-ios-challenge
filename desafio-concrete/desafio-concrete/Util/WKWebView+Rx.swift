//
//  WKWebView+Reactive.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 06/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import WebKit
import RxSwift

extension Reactive where Base: WKWebView {
  
  var isLoading: Observable<Bool> {
    return Observable.create { observer -> Disposable in
      var observationSet = Set<NSKeyValueObservation>()
      observationSet.insert(self.base.observe(\.loading, options: .new) { _, change in
        guard let value = change.newValue else { return }
        observer.onNext(value)
      })
      
      return Disposables.create {
        observationSet.removeAll()
      }
    }
    
  }
}
