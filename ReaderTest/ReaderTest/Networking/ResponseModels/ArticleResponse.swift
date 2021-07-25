//
//  ArticleResponse.swift
//  ReaderTest
//
//  Created by Maxim V. Sidorov on 7/24/21.
//

import Foundation

struct Article: Decodable {
  let udid: String
  let index: Int
  let price: Int
  let paid: String
  let unlocked: String
  let title: String
  let description: String
}

struct ArticleResponse: ResponseData {
  let success: Bool
  let data: Article
}
