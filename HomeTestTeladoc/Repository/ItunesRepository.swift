//
//  ItunesRepository.swift
//  HomeTestTeladoc
//
//  Created by Moises Apaza on 15/04/2023.
//

import RxSwift

class ItunesRepository: ItunesRepositoryContract {
    private let itunesApi = AppMoyaProvider<ItunesApi>()
    
    func getAlbums(term: String) -> Single<[Album]> {
        return itunesApi.request(.getAlbumsBy(term: term)).map(AlbumsResponse.self).map({ $0.results })
    }
}
