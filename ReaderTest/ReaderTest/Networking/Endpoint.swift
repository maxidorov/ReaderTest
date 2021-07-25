//
//  Endpoint.swift
//  ReaderTest
//
//  Created by Maxim V. Sidorov on 7/24/21.
//

import Foundation

enum Endpoint: String {
  case books = "https://akim.me/mynovels/library.php"
  case chapter = "https://akim.me/mynovels/chapter.php"

  var url: URL? {
    URL(string: rawValue)
  }
}
