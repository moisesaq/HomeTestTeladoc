//
//  ItunesRepositoryContract.swift
//  HomeTestTeladoc
//
//  Created by Moises Apaza on 15/04/2023.
//

import RxSwift

protocol ItunesRepositoryContract {
    
    func getAlbums(term: String) -> Single<[Album]>
}
