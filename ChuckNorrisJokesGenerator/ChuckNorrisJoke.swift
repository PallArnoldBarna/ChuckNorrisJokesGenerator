//
//  ChuckNorrisJoke.swift
//  ChuckNorrisJokesGenerator
//
//  Created by Pall Arnold Barna on 10.03.2026.
//

import Foundation

struct ChuckNorrisJoke: Codable {
    let id: String
    let value: String
    let categories: [String]
    let url: String
}
