//
//  ServiceError.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 08/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Foundation

enum ServiceError: Error {
  
  case timeout
  case noConnection
  case unknown
  
  static func withNSError(_ nserror: NSError) -> ServiceError {

    switch nserror.code {
    case -1001: return .timeout
    case -1009: return .noConnection
    default: return .unknown
    }
  }
  
  var localizedDescription: String {
    
    switch self {
    case .timeout: return "The request timed out."
    case .noConnection: return "The Internet connection appears to be offline."
    case .unknown: return "Unknown error."
    }
  }
}
