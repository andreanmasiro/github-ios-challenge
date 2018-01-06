//
//  PageReloadableViewController.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 05/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol PageReloadableViewController {
  
  var loadIndicator: UIActivityIndicatorView! { get }
  var scrollView: UIScrollView { get }
  var reloadBottomOffsetThreshold: CGFloat { get }
  var loading: Bool { get }
  var bag: DisposeBag { get }
  var finishedLoading: Completable? { get }
  
  var loadNextPage: (() -> ())? { get }
}

extension PageReloadableViewController where Self: UIViewController {
  
  func setUpReloadable() {
    
    finishedLoading?
      .subscribe(onCompleted: {
        self.loadIndicator.stopAnimating()
        self.fixBottomInset()
      })
      .disposed(by: bag)
    
    scrollView.rx.contentOffset
      .map { $0.y > self.scrollView.contentSize.height - self.scrollView.bounds.height - self.reloadBottomOffsetThreshold }
      .distinctUntilChanged()
      .filter { $0 && !self.loading }
      .subscribe(onNext: { _ in
        self.loadNextPage?()
      })
      .disposed(by: bag)
  }
  
  private func fixBottomInset() {
    UIView.animate(withDuration: 0.3) {
      self.scrollView.contentInset.bottom = -self.loadIndicator.bounds.height
    }
  }
}
