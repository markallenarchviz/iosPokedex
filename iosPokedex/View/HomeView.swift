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
    var body: some View {
        NavigationView {
            List {
                ForEach(searchText == "" ? pokemon : pokemon.filter({
                    $0.name.contains(searchText.lowercased())
                })) { entry in
                    HStack {
                        PokemonImage(imageLink: "\(entry.url)")
                            .padding(.trailing, 20)
                        NavigationLink("\(entry.name)".capitalized,
                                       destination: Text("Detail view for \(entry.name)"))
                    }
                    
                }
            }
            .onAppear {
                PokeApi().getData() {
                    pokemon in
                    self.pokemon = pokemon
                    
                   
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Pokedex")
        }
    }
}

#Preview {
    HomeView()
}
