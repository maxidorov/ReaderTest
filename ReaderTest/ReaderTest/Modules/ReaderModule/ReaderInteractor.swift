//
//  ReaderInteractor.swift
//  ReaderTest
//
//  Created by Maxim V. Sidorov on 7/24/21.
//

import Foundation

protocol IReaderInteractor {
  func loadArticle()
}

final class ReaderInteractor {
  private let presenter: IReaderPresenter
  private lazy var networkManager: INetworkManager = NetworkManager()

  init(presenter: IReaderPresenter) {
    self.presenter = presenter
  }
}

extension ReaderInteractor: IReaderInteractor {
  func loadArticle() {
    networkManager.loadArticle { [weak self] result in
      guard let self = self else { return }
      switch result {
      case let .success(article):
        self.presenter.showArticle(article)
      case let .failure(error):
        self.presenter.showErrorAlert(message: error.description)
      }
    }
  }
}
