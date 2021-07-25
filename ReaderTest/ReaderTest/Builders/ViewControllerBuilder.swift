//
//  ViewControllerBuilder.swift
//  ReaderTest
//
//  Created by Maxim V. Sidorov on 7/24/21.
//

import UIKit

enum Module {
  case bookList
  case reader

  var viewControllerID: String {
    switch self {
    case .bookList:
      return "BookListViewController"
    case .reader:
      return "ReaderViewController"
    }
  }
}

enum Builder {
  static var router = Router()

  static func buildModule(_ module: Module) -> UIViewController {
    let viewController = buildViewController(module)
    switch module {
    case .bookList:
      let viewController = viewController as! BooksListViewController
      let presenter = BooksListPresenter()
      let interactor = BooksListInteractor(presenter: presenter)
      presenter.viewController = viewController
      viewController.interactor = interactor
      viewController.router = router
    case .reader:
      let viewController = viewController as! ReaderViewController
      let presenter = ReaderPresenter()
      let interactor = ReaderInteractor(presenter: presenter)
      presenter.viewController = viewController
      viewController.interactor = interactor
      viewController.router = router
    }
    return viewController
  }

  private static var mainStoryboard: UIStoryboard {
    UIStoryboard(name: "Main", bundle: nil)
  }

  private static func buildViewController(_ module: Module) -> UIViewController {
    mainStoryboard.instantiateViewController(
      withIdentifier: module.viewControllerID
    )
  }
}
