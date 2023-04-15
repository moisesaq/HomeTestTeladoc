//
//  AlbumsView.swift
//  HomeTestTeladoc
//
//  Created by Moises Apaza on 15/04/2023.
//

import SwiftUI

struct AlbumsView: View {
    @ObservedObject var albumsViewModel = AlbumsViewModel()
    
    var body: some View {
        ZStack {
            List {
                ForEach(albumsViewModel.albums) { album in
                    AlbumView(album: album)
                }
            }
            if albumsViewModel.loading {
                LoadingView()
            }
        }
        .navigationTitle("The Beatles")
        .onAppear {
            albumsViewModel.loadAlbumsOfTheBeatles()
        }
        .alert(isPresented: $albumsViewModel.hasError, error: albumsViewModel.error) {
            Button("Retry") {
                albumsViewModel.loadAlbumsOfTheBeatles()
            }
        }
    }
}
