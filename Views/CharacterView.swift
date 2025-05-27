//
//  CharacterView.swift
//  RickMortyApi

import SwiftUI

struct CharacterView: View {
    @StateObject private var viewModel = CharacterViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Cargando personajes...")
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Text("⚠️ Error:")
                            .font(.headline)
                        Text(error)
                            .multilineTextAlignment(.center)
                            .padding()
                        Button("Reintentar") {
                            viewModel.fetchCharacters()
                        }
                        .padding(.top, 8)
                    }
                } else {
                    List(viewModel.characters, id: \.id) { character in
                        HStack(spacing: 16) {
                            AsyncImage(url: URL(string: character.image)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())

                            Text(character.name)
                                .font(.headline)
                        }
                        .padding(.vertical, 4)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Rick & Morty")
        }
        .onAppear {
            viewModel.fetchCharacters()
        }
    }
}

