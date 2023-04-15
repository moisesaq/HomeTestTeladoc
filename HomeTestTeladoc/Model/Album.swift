//
//  Album.swift
//  HomeTestTeladoc
//
//  Created by Moises Apaza on 15/04/2023.
//

import Foundation

struct Album: Decodable {
    let collectionId: Int
    let collectionName: String
    let artistName: String
    let artworkUrl100: String
}
