//
//  ContentView.swift
//  HomeTestTeladoc
//
//  Created by Moises Apaza on 14/04/2023.
//

import SwiftUI
import Kingfisher

struct AppView: View {
    
    var body: some View {
        NavigationView {
            AlbumsView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
