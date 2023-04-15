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
    @Published var error: AppError?
    
    init(itunesRepository: ItunesRepositoryContract! = ItunesRepository()) {
        self.itunesRepository = itunesRepository
    }
    
    func loadAlbumsOfTheBeatles() {
        loading = true
        disposable?.dispose()
        disposable = itunesRepository.getAlbums(term: "thebeatles")
            .delay(.seconds(1), scheduler: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onSuccess: { self.handleSuccess(albums: $0) },
                onFailure: { self.handleError(error: $0) }
            )
    }
    
    private func handleSuccess(albums: [Album]) {
        hideLoading()
        print("-> Albums: \(albums.count)")
        self.albums = albums
    }
    
    private func handleError(error: Error) {
        hideLoading()
        print("-> Error: \(error.localizedDescription)")
        hasError = true
        self.error = AppError.customError(message: error.localizedDescription)
    }
    
    private func hideLoading() {
        loading = false
    }
}
