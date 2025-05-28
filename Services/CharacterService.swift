//
//  CharacterService.swift
//  RickMortyApi

import Foundation

struct CharacterService {
    private let session: URLSession

    init() {
        let delegate = PinningURLSessionDelegate()
        self.session = URLSession(configuration: .default, delegate: delegate, delegateQueue: nil)
    }

    func fetchCharacters(page: Int = 1, completion: @escaping (Result<CharacterResponse, Error>) -> Void) {
        let urlString = "https://rickandmortyapi.com/api/character?page=\(page)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1,
                                        userInfo: [NSLocalizedDescriptionKey: "URL inválida"])))
            return
        }

        session.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1,
                                            userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }

            do {
                let response = try JSONDecoder().decode(CharacterResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchCharacterDetail(id: Int, completion: @escaping (Result<DetailsModel, Error>) -> Void) {
        let urlString = "https://rickandmortyapi.com/api/character/\(id)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1,
                                        userInfo: [NSLocalizedDescriptionKey: "URL inválida"])))
            return
        }

        session.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1,
                                            userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }

            do {
                let character = try JSONDecoder().decode(DetailsModel.self, from: data)
                completion(.success(character))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}


