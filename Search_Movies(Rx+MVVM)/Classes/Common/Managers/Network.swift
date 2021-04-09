//
//  Network.swift
//  Search_Movies(Rx+MVVM)
//
//  Created by 최지수 on 2021/04/09.
//

import Foundation

class Network {
    var baseURL = "https://openapi.naver.com/v1/search/movie"
    
    private func getHeader() -> [String: String] {
        let header = ["Accept": "application/json",
                      "User-Agent": "iPhone"]
        
        return header
    }
    
    func request() {
        
    }
}
