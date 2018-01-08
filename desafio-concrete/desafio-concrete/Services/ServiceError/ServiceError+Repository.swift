//
//  ServiceError+Repository.swift
//  desafio-concrete
//
//  Created by André Marques da Silva Rodrigues on 08/01/18.
//  Copyright © 2018 Vergil. All rights reserved.
//

import Foundation


extension ServiceError {
  
  enum Repository: Error {
    
    case invalidAPIPath
    case rateLimitExceeded(refreshTime: TimeInterval)
    
    var localizedDescription: String {
      
      switch self {
      case .invalidAPIPath: return "Invalid API Path."
      case .rateLimitExceeded(let refreshTime): return "Rate limit exceeded. Try again in \(refreshTime) seconds."
      }
    }
  }
}
