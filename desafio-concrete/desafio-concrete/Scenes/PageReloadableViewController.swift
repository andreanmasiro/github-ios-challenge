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
  
  var scrollView: UIScrollView { get }
  var reloadBottomOffsetThreshold: CGFloat { get }
  var loading: Bool { get }
  var bag: DisposeBag { get }
  
  var loadNextPage: (() -> ())? { get }
}

extension PageReloadableViewController where Self: UIViewController {
  
  func setUpReloadable() {
    scrollView.rx.contentOffset
      .map { $0.y > self.scrollView.contentSize.height - self.scrollView.bounds.height - self.reloadBottomOffsetThreshold }
      .distinctUntilChanged()
      .filter { $0 && !self.loading }
      .debug()
      .subscribe(onNext: { _ in
        self.loadNextPage?()
      })
      .disposed(by: bag)
  }
}

//tableView.rx.contentOffset
//  .map { $0.y > self.tableView.contentSize.height - self.tableView.bounds.height - self.reloadBottomOffsetThreshold }
//  .distinctUntilChanged()
//  .filter { $0 && !viewModel.loading.value }
//  .debug()
//  .subscribe(onNext: { _ in
//    viewModel.loadNextPage()
//  })
//  .disposed(by: bag)

