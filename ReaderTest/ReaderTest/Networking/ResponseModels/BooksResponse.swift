//
//  BooksResponse.swift
//  ReaderTest
//
//  Created by Maxim V. Sidorov on 7/24/21.
//

import Foundation

struct Book: Decodable {
  var id: Int
  var cover: String
  var title: String
  var author: String
  var symbolsCount: Int
  var tags: String

  enum CodingKeys: String, CodingKey {
    case id
    case cover
    case title
    case author
    case symbolsCount = "symbols_count"
    case tags
  }
}

struct BooksResponse: ResponseData {
  let success: Bool
  let books: [Book]
}
