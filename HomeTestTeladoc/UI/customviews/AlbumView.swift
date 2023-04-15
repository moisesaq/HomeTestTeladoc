//
//  AlbumView.swift
//  HomeTestTeladoc
//
//  Created by Moises Apaza on 15/04/2023.
//

import SwiftUI
import Kingfisher

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
