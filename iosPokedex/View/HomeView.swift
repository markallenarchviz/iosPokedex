//
//  HomeView.swift
//  iosPokedex
//
//  Created by mark on 13/05/24.
//

import SwiftUI

struct HomeView: View {
    @State var pokemon = [PokemonEntry]()
    @State var searchText = ""
    
    // Define the grid columns
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(searchText == "" ? pokemon : pokemon.filter({
                        $0.name.contains(searchText.lowercased())
                    })) { entry in
                        NavigationLink(destination: Text("Detail view for \(entry.name)")) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 120)
                                VStack {
                                    PokemonImage(imageLink: "\(entry.url)")
                                    Text(entry.name.capitalized)
                                }
                                .padding()
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            .onAppear {
                PokeApi().getData() { pokemon in
                    self.pokemon = pokemon
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Pokedex")
            .foregroundColor(.black)
        }
    }
}

#Preview {
    HomeView()
}
