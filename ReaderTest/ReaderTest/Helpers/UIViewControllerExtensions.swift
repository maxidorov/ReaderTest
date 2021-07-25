//
//  UIViewControllerExtensions.swift
//  ReaderTest
//
//  Created by Maxim V. Sidorov on 7/24/21.
//

import Foundation
import UIKit

extension UIViewController {
  func showAlert(
    message: String,
    buttonAction: @escaping () -> Void
  ) {
    let alert = UIAlertController(
      title: message,
      message: "Попробуйте еще раз",
      preferredStyle: UIAlertController.Style.alert
    )
    alert.addAction(
      UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) { _ in
        buttonAction()
      }
    )
    present(alert, animated: true)
  }
}
