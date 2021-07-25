//
//  SceneDelegate.swift
//  ReaderTest
//
//  Created by Maxim V. Sidorov on 7/24/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let mainScene = (scene as? UIWindowScene) else { return }

    let window = UIWindow(windowScene: mainScene)
    window.rootViewController = makeInitialViewController(.bookList)
    window.makeKeyAndVisible()

    self.window = window
  }

  private func makeInitialViewController(_ module: Module) -> UIViewController {
    let viewController = Builder.buildModule(.bookList)
    Builder.router.viewControllers.append(viewController)
    return viewController
  }
}

