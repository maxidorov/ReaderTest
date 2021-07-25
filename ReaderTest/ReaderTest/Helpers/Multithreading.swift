//
//  Multithreading.swift
//  ReaderTest
//
//  Created by Maxim V. Sidorov on 7/25/21.
//

import Foundation

func onMainThread(_ block: @escaping () -> Void) {
  if Thread.isMainThread {
    block()
    return
  }
  DispatchQueue.main.async {
    block()
  }
}
