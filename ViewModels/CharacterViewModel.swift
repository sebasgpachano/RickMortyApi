//
//  CharacterViewModel.swift
//  RickMortyApi

import Foundation

@MainActor
final class CharacterViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let characterService: CharacterServiceProtocol

    init(characterService: CharacterServiceProtocol = CharacterService()) {
        self.characterService = characterService
    }

    func fetchCharacters() {
        isLoading = true
        errorMessage = nil

        characterService.fetchCharacters { [weak self] result in
            guard let self = self else { return }

            Task {
                self.isLoading = false
                switch result {
                case .success(let characters):
                    self.characters = characters
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
