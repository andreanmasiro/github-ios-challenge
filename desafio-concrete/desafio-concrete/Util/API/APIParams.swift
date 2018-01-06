//
//  APIParams.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 06/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Foundation

struct APIParams {
  
  private static let pageKey = "page"
  private static let perPageKey = "per_page"
  
  static func params(page: Int, perPage: Int) -> [String: Any] {
    return [pageKey: page, perPageKey: perPage]
  }
}
