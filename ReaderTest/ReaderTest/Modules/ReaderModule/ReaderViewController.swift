//
//  ReaderViewController.swift
//  ReaderTest
//
//  Created by Maxim V. Sidorov on 7/24/21.
//

import UIKit

protocol IReaderViewController: class {
  func showArticle(_ article: Article)
  func showAlert(messsage: String)
}

final class ReaderViewController: UIViewController {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var mainTextView: UITextView!
  @IBOutlet weak var closeButton: UIButton!

  var interactor: IReaderInteractor!
  var router: IRouter!

  override func viewDidLoad() {
    super.viewDidLoad()

    setupLabel()
    setupTextView()
    setupCloseButton()

    interactor.loadArticle()
  }

  @IBAction func closeButtonAction(_ sender: UIButton) {
    Builder.router.dismiss()
  }

  private func setupLabel() {
    titleLabel.font = Brandbook.font(size: 14)
    titleLabel.textColor = .lightGray
  }

  private func setupTextView() {
    mainTextView.font = Brandbook.font(
      name: .timesNewRoman,
      size: 20
    )
    mainTextView.isEditable = false
    mainTextView.isSelectable = false
  }

  private func setupCloseButton() {
    closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
    closeButton.tintColor = .lightGray
  }
}

extension ReaderViewController: IReaderViewController {
  func showArticle(_ article: Article) {
    titleLabel.text = article.title
    mainTextView.text = article.description
  }

  func showAlert(messsage: String) {
    showAlert(
      message: messsage,
      buttonAction: interactor.loadArticle
    )
  }
}
