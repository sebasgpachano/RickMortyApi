//
//  DetailsViewModel.swift
//  RickMortyApi

import Foundation
import Combine

final class CharacterDetailViewModel: ObservableObject {
    @Published var character: Character?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let characterService = CharacterService()

    func fetchCharacter(id: Int) {
        isLoading = true
        errorMessage = nil

        characterService.fetchCharacterDetail(id: id) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let character):
                    self?.character = character
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
