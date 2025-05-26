//
//  CharacterModel.swift
//  RickMortyApi
//
//  Created by Isabella Garcia on 26/5/25.
//

import Foundation

struct CharacterResponse: Codable {
    let results: [Character]
}

struct Character: Codable, Identifiable {
    let id: Int
    let name: String
    let image: String
}
