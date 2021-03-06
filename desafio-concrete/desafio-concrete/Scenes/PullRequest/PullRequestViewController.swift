//
//  PullRequestViewController.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 06/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import UIKit
import WebKit
import RxCocoa
import RxSwift

class PullRequestViewController: UIViewController {
  
  @IBOutlet weak var webView: WKWebView!
  @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
  
  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    webView.navigationDelegate = self
  }
  
  func load(contentsOfURL url: URL) {
    
    let request = URLRequest(url: url)
    webView.load(request)
    webView.rx.isLoading
      .asDriver(onErrorJustReturn: false)
      .drive(loadIndicator.rx.isAnimating)
      .disposed(by: disposeBag)
  }
}

extension PullRequestViewController: WKNavigationDelegate {
  
  func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
    
    showErrorAlert(message: "Could not load the page.") { _ in
      self.navigationController?.popViewController(animated: true)
    }
  }
}
