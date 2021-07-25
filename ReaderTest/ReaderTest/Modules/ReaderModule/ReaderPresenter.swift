//
//  ReaderPresenter.swift
//  ReaderTest
//
//  Created by Maxim V. Sidorov on 7/24/21.
//

import Foundation
import UIKit

protocol IReaderPresenter {
  func showArticle(_ article: Article)
  func showErrorAlert(message: String)
}

final class ReaderPresenter {
  weak var viewController: IReaderViewController?
}

extension ReaderPresenter: IReaderPresenter {
  func showArticle(_ article: Article) {
    onMainThread { [weak self] in
      self?.viewController?.showArticle(article)
    }
  }

  func showErrorAlert(message: String) {
    onMainThread { [weak self] in
      self?.viewController?.showAlert(messsage: message)
    }
  }
}
