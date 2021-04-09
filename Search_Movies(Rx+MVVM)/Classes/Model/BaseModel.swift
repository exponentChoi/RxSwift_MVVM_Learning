//
//  BaseModel.swift
//  Search_Movies(Rx+MVVM)
//
//  Created by 최지수 on 2021/04/09.
//

import Foundation

struct BaseModel : Codable {
    let lastBuildDate : String?
    let total : Int?
    let start : Int?
    let display : Int?
    let items : [MovieModel]?

    enum CodingKeys: String, CodingKey {

        case lastBuildDate = "lastBuildDate"
        case total = "total"
        case start = "start"
        case display = "display"
        case items = "items"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lastBuildDate = try values.decodeIfPresent(String.self, forKey: .lastBuildDate)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        start = try values.decodeIfPresent(Int.self, forKey: .start)
        display = try values.decodeIfPresent(Int.self, forKey: .display)
        items = try values.decodeIfPresent([MovieModel].self, forKey: .items)
    }
}
