//
//  AlbumsViewModel.swift
//  HomeTestTeladoc
//
//  Created by Moises Apaza on 15/04/2023.
//

import SwiftUI
import RxSwift

class AlbumsViewModel: ObservableObject {
    private let itunesRepository: ItunesRepositoryContract
    private var disposable: Disposable?
    @Published var loading = false
    @Published var albums: [Album] = []
    @Published var hasError = false
    @Published var error: Error?
    
    init(itunesRepository: ItunesRepositoryContract! = ItunesRepository()) {
        self.itunesRepository = itunesRepository
    }
    
    func loadAlbumsOfTheBeatles() {
        loading = true
        disposable?.dispose()
        disposable = itunesRepository.getAlbums(term: "thebeatles")
            .observe(on: MainScheduler.instance)
            .subscribe(
                onSuccess: { self.handleSuccess(albums: $0) },
                onFailure: { self.handleError(error: $0) }
            )
    }
    
    private func handleSuccess(albums: [Album]) {
        hideLoading()
        self.albums = albums
    }
    
    private func handleError(error: Error) {
        hideLoading()
        hasError = true
        self.error = error
    }
    
    private func hideLoading() {
        loading = false
    }
}
