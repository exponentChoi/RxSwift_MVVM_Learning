//
//  MovieModel.swift
//  Search_Movies(Rx+MVVM)
//
//  Created by 최지수 on 2021/04/09.
//

import Foundation

struct MovieModel : Codable {
    let title : String?
    let link : String?
    let image : String?
    let subtitle : String?
    let pubDate : String?
    let director : String?
    let actor : String?
    let userRating : String?

    enum CodingKeys: String, CodingKey {

        case title = "title"
        case link = "link"
        case image = "image"
        case subtitle = "subtitle"
        case pubDate = "pubDate"
        case director = "director"
        case actor = "actor"
        case userRating = "userRating"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        link = try values.decodeIfPresent(String.self, forKey: .link)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        subtitle = try values.decodeIfPresent(String.self, forKey: .subtitle)
        pubDate = try values.decodeIfPresent(String.self, forKey: .pubDate)
        director = try values.decodeIfPresent(String.self, forKey: .director)
        actor = try values.decodeIfPresent(String.self, forKey: .actor)
        userRating = try values.decodeIfPresent(String.self, forKey: .userRating)
    }
}
