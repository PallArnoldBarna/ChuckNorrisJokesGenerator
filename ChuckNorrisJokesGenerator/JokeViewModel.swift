//
//  JokeViewModel.swift
//  ChuckNorrisJokesGenerator
//
//  Created by Pall Arnold Barna on 10.03.2026.
//

import Foundation
import Combine

class JokeViewModel: ObservableObject {
    @Published var joke: String = Strings.Text.jokePlaceholderText
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var selectedCategory: String = Strings.Text.randomText
    @Published var categoriesList: [String] = [Strings.Text.randomText]
    
    func fetchJoke() async {
        isLoading = true
        errorMessage = nil
        
        let urlString: String
        if selectedCategory == Strings.Text.randomText {
            urlString = Strings.APIConstants.baseURL + Strings.APIConstants.randomPath
        } else {
            urlString = Strings.APIConstants.baseURL + Strings.APIConstants.categoryPath + selectedCategory
        }
        
        guard let jokeURL = URL(string: urlString) else {
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: jokeURL)
            let decoded = try JSONDecoder().decode(ChuckNorrisJoke.self, from: data)
            joke = decoded.value
        } catch {
            errorMessage = Strings.Text.fetchJokeError
        }
        
        isLoading = false
    }
    
    func fetchCategories() async {
        guard let categoriesURL = URL(string: Strings.APIConstants.baseURL + Strings.APIConstants.categoriesPath) else {
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: categoriesURL)
            let decoded = try JSONDecoder().decode([String].self, from: data)
            categoriesList.append(contentsOf: decoded)
        } catch {
            errorMessage = Strings.Text.fetchCategoriesError
        }
    }
}
