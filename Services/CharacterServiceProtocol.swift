//
//  CharacterServiceProtocol.swift
//  RickMortyApi

import Foundation

protocol CharacterServiceProtocol {
    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void)
}
