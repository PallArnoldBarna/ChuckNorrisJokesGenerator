//
//  JokeViewModel.swift
//  ChuckNorrisJokesGenerator
//
//  Created by Pall Arnold Barna on 10.03.2026.
//

import Foundation
import Combine

class JokeViewModel: ObservableObject {
    @Published var joke: String = "Tap the button to get a Chuck Norris joke!"
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var selectedCategory: String = "random"
    @Published var categoriesList: [String] = ["random"]
    
    func fetchJoke() async {
        isLoading = true
        errorMessage = nil
        
        let urlString: String
        if selectedCategory == "random" {
            urlString = APIConstants.baseURL + APIConstants.randomPath
        } else {
            urlString = APIConstants.baseURL + APIConstants.categoryPath + selectedCategory
        }
        
        guard let jokeURL = URL(string: urlString) else {
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: jokeURL)
            let decoded = try JSONDecoder().decode(ChuckNorrisJoke.self, from: data)
            joke = decoded.value
        } catch {
            errorMessage = "Failed to load joke. Try again!"
        }
        
        isLoading = false
    }
    
    func fetchCategories() async {
        guard let categoriesURL = URL(string: APIConstants.baseURL + APIConstants.categoriesPath) else {
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: categoriesURL)
            let decoded = try JSONDecoder().decode([String].self, from: data)
            categoriesList.append(contentsOf: decoded)
        } catch {
            errorMessage = "Failed to load categories."
        }
    }
}

enum APIConstants {
    static let baseURL = "https://api.chucknorris.io/"
    static let randomPath = "jokes/random"
    static let categoryPath = "jokes/random?category="
    static let categoriesPath = "jokes/categories"
}
