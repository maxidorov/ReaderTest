//
//  Brandbook.swift
//  ReaderTest
//
//  Created by Maxim V. Sidorov on 7/24/21.
//

import UIKit

final class Brandbook { }

// MARK: - Fonts
extension Brandbook {

  enum FontName: String {
    case `default` = "HelveticaNeue"
    case timesNewRoman = "TimesNewRomanPS"
  }

  enum Weight: String {
    case thin = "Thin"
    case regular = "Regular"
    case bold = "Bold"
    case medium = "Medium"
    case heavy = "Heavy"
  }

  static func font(
    name: FontName = .default,
    size: CGFloat = 20,
    weight: Weight = .regular
  ) -> UIFont {
    let fontName: String
    switch name {
    case .timesNewRoman:
      fontName =  "\(name.rawValue)\(fontExtension(weight))MT"
    default:
      fontName = "\(name.rawValue)\(fontExtension(weight))"
      break
    }
    if let font = UIFont(name: fontName, size: size) {
      return font
    }
    return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.regular)
  }

  static private func fontExtension(_ weight: Weight) -> String {
    switch weight {
    case .regular:
      return ""
    default:
      return "-\(weight.rawValue)"
    }
  }
}
