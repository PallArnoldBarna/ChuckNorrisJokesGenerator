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
    
    func fetchJoke() async {
        isLoading = true
        errorMessage = nil
        
        guard let url = URL(string: APIConstants.baseURL + APIConstants.randomPath) else {
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(ChuckNorrisJoke.self, from: data)
            joke = decoded.value
        } catch {
            errorMessage = "Failed to load joke. Try again!"
        }
        
        isLoading = false
    }
}

enum APIConstants {
    static let baseURL = "https://api.chucknorris.io/"
    static let randomPath = "jokes/random"
    static let imagePath = "img/avatar/chuck-norris.png"
}
