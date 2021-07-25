//
//  BooksListPresenter.swift
//  ReaderTest
//
//  Created by Maxim V. Sidorov on 7/24/21.
//

import Foundation
import UIKit

protocol IBooksListPresenter {
  func showBooks(_ books: [Book])
  func setImage(_ image: UIImage, index: Int)
  func showErrorAlert(message: String)
}

final class BooksListPresenter {
  weak var viewController: IBooksListViewController?
}

extension BooksListPresenter: IBooksListPresenter {
  func showBooks(_ books: [Book]) {
    let bookPreviews = books.map(BookPreview.init)
    onMainThread { [weak self] in
      self?.viewController?.showBookPreviews(bookPreviews)
    }
  }

  func setImage(_ image: UIImage, index: Int) {
    onMainThread { [weak self] in
      self?.viewController?.setImage(image, bookIndex: index)
    }
  }

  func showErrorAlert(message: String) {
    onMainThread { [weak self] in
      self?.viewController?.showAlert(messsage: message)
    }
  }
}
