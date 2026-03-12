//
//  StringsEnum.swift
//  ChuckNorrisJokesGenerator
//
//  Created by Pall Arnold Barna on 11.03.2026.
//

import Foundation

enum Strings {
    enum Text {
        static let titleText = "Chuck Norris Joke Generator"
        static let jokePlaceholderText = "Tap the button to get a Chuck Norris joke!"
        static let buttonText = "Get a Joke"
        static let fetchJokeError = "Failed to load joke. Try again!"
        static let fetchCategoriesError = "Failed to load categories."
        static let randomText = "random"
    }
    
    enum Image {
        static let logoImage = "chucknorris_logo"
        static let buttonImage = "bolt.fill"
    }
    
    enum APIConstants {
        static let baseURL = "https://api.chucknorris.io/"
        static let randomPath = "jokes/random"
        static let categoryPath = "jokes/random?category="
        static let categoriesPath = "jokes/categories"
    }
}
