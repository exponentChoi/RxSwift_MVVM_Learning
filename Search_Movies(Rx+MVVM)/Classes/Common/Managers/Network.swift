//
//  Network.swift
//  Search_Movies(Rx+MVVM)
//
//  Created by 최지수 on 2021/04/09.
//

import Foundation

class Network {
    
    private func getHeader() -> [String: String] {
        let header = ["X-Naver-Client-Id": "",
                      "X-Naver-Client-Secret": ""]
        return header
    }
    
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
}
