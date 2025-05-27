//
//  CharacterModel.swift
//  RickMortyApp

import Foundation

struct CharacterModel: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let image: String
}
