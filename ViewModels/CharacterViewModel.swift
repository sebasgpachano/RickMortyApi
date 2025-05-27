//
//  CharacterViewModel.swift
//  RickMortyApi

import Foundation
import Combine

final class CharacterViewModel: ObservableObject {
    @Published var characters: [CharacterModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service = CharacterService()
    private var currentPage = 1
    private var totalPages = 1
    private var isFetching = false

    func fetchCharacters() {
        // ⚠️ Evitar múltiples llamadas simultáneas
        guard !isFetching, currentPage <= totalPages else { return }

        isLoading = true
        errorMessage = nil
        isFetching = true

        service.fetchCharacters(page: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }

                self.isLoading = false
                self.isFetching = false

                switch result {
                case .success(let response):
                    self.characters += response.results
                    self.totalPages = response.info.pages
                    self.currentPage += 1
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}


