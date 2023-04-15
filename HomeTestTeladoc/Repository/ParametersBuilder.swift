//
//  ParametersBuilder.swift
//  HomeTestTeladoc
//
//  Created by Moises Apaza on 15/04/2023.
//

import Foundation

struct ParametersBuilder {
    let term: String
    
    func build() -> [String: String] {
        return ["term": term, "media": "music", "entity": "album"]
    }
}
