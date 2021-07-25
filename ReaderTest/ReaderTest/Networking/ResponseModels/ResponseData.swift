//
//  ResponseData.swift
//  ReaderTest
//
//  Created by Maxim V. Sidorov on 7/24/21.
//

import Foundation

protocol ResponseData: Decodable {
  var success: Bool { get }
}
