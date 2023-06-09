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
    
    init(itunesRepository: ItunesRepositoryContract) {
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
    
    func setFakeValue() {
        albums = [Album(collectionId: 123, collectionName: "", artistName: "", artworkUrl100: "")]
    }
    
    private func handleSuccess(albums: [Album]) {
        hideLoading()
        self.albums = albums
    }
    
    private func handleError(error: Error) {
        hideLoading()
        hasError = true
        self.error = AppError.customError(message: error.localizedDescription)
    }
    
    private func hideLoading() {
        loading = false
    }
}
