//
//  CharacterService.swift
//  RickMortyApi
//
//  Created by Isabella Garcia on 27/5/25.
//

import Foundation

struct CharacterService {
    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        let url = URL(string: "https://rickandmortyapi.com/api/character")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }

            do {
                let response = try JSONDecoder().decode(CharacterResponse.self, from: data)
                completion(.success(response.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

