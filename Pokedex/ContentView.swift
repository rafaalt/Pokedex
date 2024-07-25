//
//  ContentView.swift
//  Pokedex
//
//  Created by Rafael Torga on 24/07/24.
//

import Alamofire
import Kingfisher
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "trash")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .font(.title)
                .bold()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.cyan)
    }
}

#Preview {
    ContentView()
}
