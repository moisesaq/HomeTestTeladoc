//
//  ContentView.swift
//  HomeTestTeladoc
//
//  Created by Moises Apaza on 14/04/2023.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @ObservedObject var albumsViewModel = AlbumsViewModel()
    
    var body: some View {
        NavigationView {
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AlbumView: View {
    @State var album: Album
    
    var body: some View {
        HStack {
            KFImage(album.getAlbumImage())
                .frame(width: 64, height: 64)
                .font(.system(size: 24))
                .cornerRadius(4)
                .shadow(color: .gray, radius: 4, x: 0.0, y: 2)
            Text(album.collectionName)
                .font(.system(size: 14, weight: .semibold))
                .padding(.horizontal)
        }
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
