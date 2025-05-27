//
//  DetailsModel.swift
//  RickMortyApi


import Foundation

struct DetailsModel: Codable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
}
