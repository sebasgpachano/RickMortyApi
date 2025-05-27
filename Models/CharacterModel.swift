//
//  CharacterModel.swift
//  RickMortyApp

import Foundation

struct CharacterResponse: Codable {
    let results: [Character]
}

struct Character: Codable, Identifiable {
    let id: Int
    let name: String
    let image: String
}
