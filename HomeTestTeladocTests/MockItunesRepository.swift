//
//  MockItunesRepository.swift
//  HomeTestTeladocTests
//
//  Created by Moises Apaza on 15/04/2023.
//

import Foundation
import RxSwift

class MockItunesRepository: ItunesRepositoryContract {
    
    func getAlbums(term: String) -> Single<[Album]> {
        return Single.just([Album(collectionId: 123, collectionName: "", artistName: "", artworkUrl100: "")])
    }
}

class MockEmptyItunesRepository: ItunesRepositoryContract {
    
    func getAlbums(term: String) -> Single<[Album]> {
        return Single.just([])
    }
}

class MockErrorItunesRepository: ItunesRepositoryContract {
    
    func getAlbums(term: String) -> Single<[Album]> {
        return Single.error(AppError.customError(message: "Mock repository error"))
    }
}
