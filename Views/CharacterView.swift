//
//  CharacterView.swift
//  RickMortyApi

import SwiftUI

struct CharacterView: View {
    @StateObject private var viewModel = CharacterViewModel()

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Personajes")
                .navigationDestination(for: Int.self) { characterId in
                            DetailsView(characterId: characterId)
                        }
        }
        .onAppear {
            if viewModel.characters.isEmpty {
                viewModel.fetchCharacters()
            }
        }
    }

    private var content: some View {
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
                    // 🔁 Usa NavigationLink correctamente
                    NavigationLink(value: character.id) {
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
                    .onAppear {
                        if character == viewModel.characters.last {
                            viewModel.fetchCharacters()
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
    }
}


