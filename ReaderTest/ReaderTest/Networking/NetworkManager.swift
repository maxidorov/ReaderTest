//
//  NetworkManager.swift
//  ReaderTest
//
//  Created by Maxim V. Sidorov on 7/24/21.
//

import Foundation
import UIKit

typealias ResultBlock<T> = (Result<T, NetworkError>) -> Void
typealias DataTaskParams = (data: Data?, response: URLResponse?, error: Error?)

protocol INetworkManager {
  func loadBooks(completion: @escaping ResultBlock<[Book]>)
  func loadArticle(completion: @escaping ResultBlock<Article>)
  func loadImage(url: URL, completion: @escaping ResultBlock<UIImage>)
}

final class NetworkManager {
  private lazy var session = URLSession.shared
  private lazy var jsonDecoder = JSONDecoder()
}

extension NetworkManager: INetworkManager {
  func loadBooks(completion: @escaping ResultBlock<[Book]>) {
    getDecoded(
      url: Endpoint.books.url
    ) { (result: Result<BooksResponse, NetworkError>) -> Void in
      switch result {
      case let .success(bookResponse):
        completion(.success(bookResponse.books))
      case let .failure(error):
        completion(.failure(error))
      }
    }
  }

  func loadArticle(completion: @escaping ResultBlock<Article>) {
    getDecoded(
      url: Endpoint.chapter.url
    ) { (result: Result<ArticleResponse, NetworkError>) -> Void in
      switch result {
      case let .success(articleResponse):
        completion(.success(articleResponse.data))
      case let .failure(error):
        completion(.failure(error))
      }
    }
  }

  func loadImage(url: URL, completion: @escaping ResultBlock<UIImage>) {
    session.dataTask(with: url) { [weak self] (data, response, error) in
      guard let self = self else {
        completion(.failure(.networkManagerDeallocated))
        return
      }
      let dataTaskParams = (data, response, error)
      self.handleError(block: dataTaskParams) { result in
        switch result {
        case let .success(data):
          guard let image = UIImage(data: data) else {
            completion(.failure(.imageDecodingError))
            return
          }
          completion(.success(image))
          return
        case let .failure(error):
          completion(.failure(error))
          return
        }
      }
    }.resume()
  }

  private func getDecoded<T: ResponseData>(
    url: URL?,
    completion: @escaping ResultBlock<T>
  ) {
    guard let url = url else {
      completion(.failure(.invalidURL))
      return
    }
    session.dataTask(with: url) { [weak self] (data, response, error) in
      guard let self = self else {
        completion(.failure(.networkManagerDeallocated))
        return
      }
      let dataTaskParams = (data, response, error)
      self.handleError(block: dataTaskParams) { result in
        switch result {
        case let .success(data):
          do {
            let responseData = try self.jsonDecoder.decode(T.self, from: data)
            guard responseData.success else {
              completion(.failure(.responseNotSucceed))
              return
            }
            completion(.success(responseData))
          } catch {
            completion(.failure(.jsonDecodingError))
            return
          }
        case let .failure(error):
          completion(.failure(error))
          return
        }
      }
    }.resume()
  }

  private func handleError(
    block: DataTaskParams,
    completion: @escaping ResultBlock<Data>
  ) {
    if let error = block.error {
      completion(.failure(.internalError(error)))
      return
    }

    guard let httpCode = (block.response as? HTTPURLResponse)?.statusCode else {
      completion(.failure(.invalidResponse))
      return
    }

    guard (200...299).contains(httpCode) else {
      completion(.failure(.invalidHTTPCode(httpCode)))
      return
    }

    guard let data = block.data else {
      completion(.failure(.invalidData))
      return
    }

    completion(.success(data))
    return
  }
}
