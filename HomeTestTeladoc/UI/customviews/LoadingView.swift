//
//  LoadingView.swift
//  HomeTestTeladoc
//
//  Created by Moises Apaza on 15/04/2023.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .black))
                .scaleEffect(2)
        }
    }
}
