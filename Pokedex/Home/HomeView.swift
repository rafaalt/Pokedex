//
//  HomeView.swift
//  Pokedex
//
//  Created by Rafael Torga on 22/07/24.
//

import SwiftUI

struct HomeView: View {

    private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack{
            Text("Hello, World!")
            Button(action: {
                viewModel.getPokemon(id: 5)
            }) {
                Text("Teste Button")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
    
}

#Preview {
    HomeView(viewModel: .init())
}
