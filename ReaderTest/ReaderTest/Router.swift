//
//  Router.swift
//  ReaderTest
//
//  Created by Maxim V. Sidorov on 7/24/21.
//

import Foundation
import UIKit

struct WeakBox<T: AnyObject> {
  var value: T?

  init(_ value: T) {
    self.value = value
  }
}

struct WeakArray<T: AnyObject> {
  private var array: [WeakBox<T>] = []

  var last: T? {
    array.last?.value
  }

  mutating func append(_ value: T) {
    array.append(WeakBox(value))
  }

  mutating func pop() {
    array.removeLast()
  }
}

protocol IRouter {
  var viewControllers: [UIViewController] { get set }
  
  func present(_ module: Module)
  func dismiss()
}

final class Router {
  var viewControllers: [UIViewController] = []
}

extension Router: IRouter {
  func present(_ module: Module) {
    let viewController = Builder.buildModule(module)
    viewController.modalPresentationStyle = .overFullScreen
    viewControllers.last?.present(viewController, animated: true) {
      self.viewControllers.append(viewController)
    }
  }

  func dismiss() {
    viewControllers.last?.dismiss(animated: true, completion: nil)
    viewControllers.removeLast()
  }
}
