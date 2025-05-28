//
//  DetailsView.swift
//  RickMortyApi

import SwiftUI

struct DetailsView: View {
    @StateObject private var viewModel = DetailsViewModel()
    let characterId: Int

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Cargando...")
            } else if let character = viewModel.character {
                ScrollView {
                    VStack(spacing: 16) {
                        AsyncImage(url: URL(string: character.image)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(maxWidth: 300)

                        Text(character.name)
                            .font(.largeTitle)
                            .bold()

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Status: \(character.status)")
                            Text("Species: \(character.species)")
                            Text("Gender: \(character.gender)")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    }
                    .padding()
                }
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            } else {
                EmptyView()
            }
        }
        .onAppear {
            print("Character ID:", characterId)
            viewModel.fetchCharacter(id: characterId)
        }
        .navigationTitle("Detalle")
    }
}
