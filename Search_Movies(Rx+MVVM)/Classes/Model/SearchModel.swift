//
//  SearchModel.swift
//  Search_Movies(Rx+MVVM)
//
//  Created by 최지수 on 2021/04/09.
//

import Foundation

struct SearchModel {
    let query: String        // 검색어(UTF-8인코딩 필요)
    let display: Int? = nil         // 검색결과 출력건수 (10 ~ 100)
    let start: Int?           // 검색 시작 위치 (1~ 1000, [**1000 이상은 불가**])
    let genre: GenreType?     // 영화장르 검색 옵션
    let country: CountryCode? // 검색 대상 국가 코드 (대문자만 가능)
    
    // yearfrom과 yearto는 함께 사용
    let yearfrom: String? // 영화제작년도 (최대)
    let yearto: String?   // 영화제작년도 (최소)
    
//    init(query: String, display: Int, start: Int, genre: GenreType, country: CountryCode) {
//        self.query = query
//        self.display = display
//        self.start = start
//        self.genre = genre
//        self.country = country
//    }
}
