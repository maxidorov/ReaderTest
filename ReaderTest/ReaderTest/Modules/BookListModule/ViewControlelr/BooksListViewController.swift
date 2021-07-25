//
//  ViewController.swift
//  ReaderTest
//
//  Created by Maxim V. Sidorov on 7/24/21.
//

import UIKit

protocol IBooksListViewController: class {
  func showBookPreviews(_ bookPreviews: [BookPreview])
  func setImage(_ image: UIImage, bookIndex: Int)
  func showAlert(messsage: String)
}

final class BooksListViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!

  private var layout = BooksListCollectionViewLayout()
  private var bookPreviews: [BookPreview] = [] {
    didSet {
      collectionView.reloadData()
    }
  }

  var interactor: IBooksListInteractor!
  var router: IRouter!

  override func viewDidLoad() {
    super.viewDidLoad()

    setupCollectionView()
    interactor.loadBooks()
  }

  private func setupCollectionView() {
    let celllNib = UINib(nibName: "BookPreviewCell", bundle: nil)
    collectionView.register(
      celllNib,
      forCellWithReuseIdentifier: BookPreviewCell.cellID
    )
    collectionView.alwaysBounceVertical = true
    collectionView.bounces = true
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    layout = BooksListCollectionViewLayout.calculate(
      cellsCount: (inRow: 3, inColumn: 3),
      cellsSpacing: (vertical: 8, horizontal: 8),
      collectionViewSize: collectionView.frame.size,
      collectionViewSafeArea: collectionView.safeAreaInsets
    )
  }
}

extension BooksListViewController: IBooksListViewController {
  func showBookPreviews(_ bookPreviews: [BookPreview]) {
    self.bookPreviews = bookPreviews
  }

  func setImage(_ image: UIImage, bookIndex: Int) {
    bookPreviews[bookIndex].image = image
  }

  func showAlert(messsage: String) {
    showAlert(
      message: messsage,
      buttonAction: interactor.loadBooks
    )
  }
}

extension BooksListViewController: UICollectionViewDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    router.present(.reader)
  }
}

extension BooksListViewController: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    bookPreviews.count
  }

  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: BookPreviewCell.cellID, for: indexPath
    ) as! BookPreviewCell
    cell.configure(with: bookPreviews[indexPath.row])
    return cell
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    layout.insets
  }
}

extension BooksListViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    layout.cellSize
  }
}
