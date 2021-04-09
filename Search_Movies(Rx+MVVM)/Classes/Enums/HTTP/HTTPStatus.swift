//
//  HTTPStatus.swift
//  Search_Movies(Rx+MVVM)
//
//  Created by 최지수 on 2021/04/09.
//

import Foundation

enum HTTPStatus: Int {
    // Success Response
    case Ok = 200
    
    // Client Error Response
    case BasRequest = 400
    case Unauthorized = 401
    case Forbidden = 403
    case NotFound = 404
    case RequestTimeout = 408
    case Conflict = 409
    
    // Server Error Response
    case InternalServerError = 500
    case ServiceUnavailable = 503
}
