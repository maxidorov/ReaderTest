//
//  BookListLayout.swift
//  ReaderTest
//
//  Created by Maxim V. Sidorov on 7/24/21.
//

import Foundation
import UIKit

struct BooksListCollectionViewLayout {
  struct Constants {
    static let insets = UIEdgeInsets(allEqual: 16)
  }

  let insets: UIEdgeInsets
  let cellSize: CGSize

  init(insets: UIEdgeInsets, cellSize: CGSize) {
    self.insets = insets
    self.cellSize = cellSize
  }

  init() {
    self.init(insets: .zero, cellSize: .zero)
  }

  static func calculate(
    cellsCount: (inRow: Int, inColumn: Int),
    cellsSpacing: (vertical: CGFloat, horizontal: CGFloat),
    collectionViewSize: CGSize,
    collectionViewSafeArea: UIEdgeInsets
  ) -> Self {
    let widthWithoutInsets = collectionViewSize.width
      - Constants.insets.left
      - Constants.insets.right
      - CGFloat((cellsCount.inRow - 1)) * cellsSpacing.vertical

    let heightWithourInsets = collectionViewSize.height
      - CGFloat((cellsCount.inColumn - 1)) * cellsSpacing.horizontal
      - max(Constants.insets.top, collectionViewSafeArea.top)
      - max(Constants.insets.bottom, collectionViewSafeArea.bottom)

    let cellSize = CGSize(
      width: widthWithoutInsets / CGFloat(cellsCount.inRow) - 2,
      height: heightWithourInsets / CGFloat(cellsCount.inColumn)
    )

    return BooksListCollectionViewLayout(
      insets: Constants.insets,
      cellSize: cellSize
    )
  }
}

private extension UIEdgeInsets {
  init(allEqual inset: CGFloat) {
    self.init(
      top: inset,
      left: inset,
      bottom: inset,
      right: inset
    )
  }
}
