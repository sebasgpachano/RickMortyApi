//
//  CharacterViewModel.swift
//  RickMortyApi

import Foundation

final class CharacterViewModel: ObservableObject {
    @Published var characters: [CharacterModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service = CharacterService()

    func fetchCharacters() {
        isLoading = true
        errorMessage = nil

        service.fetchCharacters { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    self?.characters = response.results
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

