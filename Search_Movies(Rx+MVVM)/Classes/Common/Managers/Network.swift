//
//  Network.swift
//  Search_Movies(Rx+MVVM)
//
//  Created by 최지수 on 2021/04/09.
//

import Foundation
import RxSwift

class Network {
    private func getHeader() -> [String: String] {
        let header = ["X-Naver-Client-Id": "mivorrj52o7Y_25Xq5BE",
                      "X-Naver-Client-Secret": "QMikpc1Tlu"]
        return header
    }
    
    // MARK: - 기존 Request 함수
    func request<T: Decodable>(method: HTTPMethod = .get,
                               parameters: [String: Any] = [:],
                               responseType: T.Type,
                               successHandler: @escaping (BaseModel<T>) -> (),
                               failureHandler: @escaping (BaseError) -> ()) {
    
        var components = URLComponents(string: "https://openapi.naver.com/v1/search/movie")!
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: "\(value)")
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        var request = URLRequest(url: components.url!)
        request.allHTTPHeaderFields = getHeader()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                failureHandler(BaseError(code: "500", message: error?.localizedDescription ?? "Network error"))
                return
            }

            guard let response = response as? HTTPURLResponse,  // is there HTTP response
                  (200 ..< 300) ~= response.statusCode,         // is statusCode 2XX
                  error == nil else {                           // was there no error, otherwise ...
                
                if let baseError = try? JSONDecoder().decode(BaseError.self, from: data) {
                    failureHandler(baseError)
                } else {
                    failureHandler(BaseError(code: "500", message: error?.localizedDescription ?? "Network error"))
                }
                return
            }
            
            guard let decode = try? JSONDecoder().decode(BaseModel<T>.self, from: data) else {
                failureHandler(BaseError(code: response.statusCode.description,
                                         message: "Decode Error"))
                return
            }
            
            successHandler(decode)
        
        }
        task.resume()
    }
    
    // MARK: - Rx를 적용한 Request 함수 (Single 사용)
    func rxRequest<T: Decodable>(method: HTTPMethod = .get,
                   parameters: [String: Any] = [:],
                   responseType: T.Type) -> Single<NetworkResult<T>> {
        
        var components = URLComponents(string: "https://openapi.naver.com/v1/search/movie")!
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: "\(value)")
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        var request = URLRequest(url: components.url!)
        request.allHTTPHeaderFields = getHeader()
        
        return Single.create { single in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    single(.failure(error))
                }

                if let response = response as? HTTPURLResponse,
                   (400..<500) ~= response.statusCode {
                    var baseError = BaseError(code: String(response.statusCode), message: "서버와의 통신이 원할하지 않습니다.\n다시 시도해 주세요.")

                    if let data = data,
                       let errorResp = try? JSONDecoder().decode(BaseError.self, from: data) {
                        baseError = errorResp
                    }

                    single(.success(.error(baseError)))
                }

                if let data = data,
                   let decode = try? JSONDecoder().decode(BaseModel<T>.self, from: data) {
                    single(.success(.success(decode)))
                }
            }

            task.resume()
            return Disposables.create()
        }
    }
}

enum NetworkResult<C: Decodable> {
    case success(BaseModel<C>)
    case error(BaseError)
}

enum NetworkError: Int, Error {
  case badRequest = 400
  case authenticationFailed = 401
  case notFoundException = 404
  case contentLengthError = 413
  case quotaExceeded = 429
  case systemError = 500
  case endpointError = 503
  case timeout = 504
}
