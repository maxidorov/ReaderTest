//
//  BookPreviewCell.swift
//  ReaderTest
//
//  Created by Maxim V. Sidorov on 7/24/21.
//

import UIKit

final class BookPreviewCell: UICollectionViewCell {
  static let cellID = "BookPreviewCell"

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    setupImageView()
    setupLabels()
  }

  func configure(with bookPreview: BookPreview) {
    imageView.image = bookPreview.image
    titleLabel.text = bookPreview.title
    subtitleLabel.text = bookPreview.author
  }

  private func setupImageView() {
    imageView.contentMode = .scaleToFill
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = 8
  }

  private func setupLabels() {
    titleLabel.font = Brandbook.font(size: 13, weight: .bold)
    titleLabel.textColor = .black
    titleLabel.setFontAutoresizing()
    titleLabel.numberOfLines = 2

    subtitleLabel.font = Brandbook.font(size: 11, weight: .regular)
    subtitleLabel.textColor = .lightGray
    subtitleLabel.setFontAutoresizing()
    subtitleLabel.numberOfLines = 1
  }
}

private extension UILabel {
  func setFontAutoresizing() {
    adjustsFontSizeToFitWidth = true
    minimumScaleFactor = 0.7
  }
}
