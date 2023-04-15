//
//  ContentView.swift
//  HomeTestTeladoc
//
//  Created by Moises Apaza on 14/04/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var albumsViewModel = AlbumsViewModel()
    
    var body: some View {
        ZStack {
            List {
                ForEach(albumsViewModel.albums) { album in
                    Text(album.collectionName)
                }
            }
            if albumsViewModel.loading {
                LoadingView()
            }
        }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .black))
                .scaleEffect(3)
        }
    }
}
