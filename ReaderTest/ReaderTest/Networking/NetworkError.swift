//
//  NetworkingError.swift
//  ReaderTest
//
//  Created by Maxim V. Sidorov on 7/24/21.
//

import Foundation

enum NetworkError: Error {
  case networkManagerDeallocated
  case invalidURL
  case invalidData
  case invalidResponse
  case invalidHTTPCode(Int)
  case internalError(Error)
  case jsonDecodingError
  case responseNotSucceed
  case imageDecodingError

  var description: String {
    "Что-то пошло не так..."
  }

  var detailedDescription: String {
    "[More detailed description]"
  }
}
