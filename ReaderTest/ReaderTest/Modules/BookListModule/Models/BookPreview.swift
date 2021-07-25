//
//  BookPreview.swift
//  ReaderTest
//
//  Created by Maxim V. Sidorov on 7/24/21.
//

import Foundation
import UIKit

struct BookPreview {
  var image: UIImage? = nil
  let title: String
  let author: String

  init(book: Book) {
    self.title = book.title
    self.author = book.author
  }
}
