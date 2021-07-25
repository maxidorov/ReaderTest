//
//  BooksListInteractor.swift
//  ReaderTest
//
//  Created by Maxim V. Sidorov on 7/24/21.
//

import Foundation

protocol IBooksListInteractor {
  func loadBooks()
}

final class BooksListInteractor {
  private let presenter: IBooksListPresenter
  private lazy var networkManager: INetworkManager = NetworkManager()

  init(presenter: IBooksListPresenter) {
    self.presenter = presenter
  }
}

extension BooksListInteractor: IBooksListInteractor {
  func loadBooks() {
    networkManager.loadBooks { [weak self] result in
      guard let self = self else { return }
      switch result {
      case let .success(books):
        self.presenter.showBooks(books)
        for (index, book) in books.enumerated() {
          guard let url = URL(string: book.cover) else {
            continue
          }

          self.networkManager.loadImage(url: url) { result in
            switch result {
            case let .success(image):
              self.presenter.setImage(image, index: index)
            case let .failure(error):
              self.presenter.showErrorAlert(message: error.localizedDescription)
            }
          }
        }
      case let .failure(error):
        print(error.detailedDescription)

        DispatchQueue.main.async {
          self.presenter.showErrorAlert(message: error.description)
        }
      }
    }
  }
}
