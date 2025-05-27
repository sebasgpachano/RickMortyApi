//
//  CharacterResponse.swift
//  RickMortyApi

import Foundation

struct CharacterResponse: Codable {
    let info: PageInfo
    let results: [CharacterModel]
}

struct PageInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
