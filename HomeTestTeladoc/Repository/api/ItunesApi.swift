//
//  ItunesApi.swift
//  HomeTestTeladoc
//
//  Created by Moises Apaza on 14/04/2023.
//

import Foundation
import Moya
import Alamofire

enum ItunesApi {
    case getAlbumsBy(term: String)
}

extension ItunesApi: TargetType {
    var baseURL: URL {
        return URL(string: "https://itunes.apple.com")!
    }
    
    var path: String {
        return "/search"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .getAlbumsBy(let term):
            let parameters = ParametersBuilder(term: term).build()
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
        
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
