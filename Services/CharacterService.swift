//
//  CharacterService.swift
//  RickMortyApi
//
//  Created by Isabella Garcia on 27/5/25.
//

import Foundation

final class CharacterService: CharacterServiceProtocol {
    private let session: URLSession

    init() {
        let delegate = PinnedSessionDelegate()
        self.session = URLSession(configuration: .default, delegate: delegate, delegateQueue: nil)
    }

    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }

        session.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0)))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(CharacterResponse.self, from: data)
                completion(.success(decoded.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
