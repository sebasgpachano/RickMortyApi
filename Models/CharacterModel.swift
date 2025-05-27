//
//  CharacterModel.swift
//  RickMortyApp

import Foundation

struct CharacterModel: Codable, Identifiable {
    let id: Int
    let name: String
    let image: String
}
