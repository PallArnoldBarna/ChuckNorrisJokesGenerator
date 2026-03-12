//
//  ContentView.swift
//  ChuckNorrisJokesGenerator
//
//  Created by Pall Arnold Barna on 10.03.2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = JokeViewModel()
    @Environment(\.colorScheme) public var colorScheme
    
    var body: some View {
        ZStack {
            colorScheme == .dark ? Color.black.ignoresSafeArea() : Color.white.ignoresSafeArea()
            
            VStack(spacing: 30) {
                Image(Strings.Image.logoImage)
                    .logoStyle()
                
                Text(Strings.Text.titleText)
                    .titleStyle(colorScheme: colorScheme)
                
                ZStack {
                    Rectangle()
                        .jokeBoxStyle(colorScheme: colorScheme)
                    ScrollView(showsIndicators: false) {
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle()
                        } else {
                            Text(viewModel.errorMessage ?? viewModel.joke)
                                .jokeBoxTextStyle(colorScheme: colorScheme)
                        }
                    }
                    .jokeBoxScrollViewStyle()
                }
                .jokeBoxSize()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(viewModel.categoriesList, id: \.self) { category in
                            let isSelected = viewModel.selectedCategory == category
                            let label = category == Strings.Text.randomText ? Strings.Text.randomText.capitalized : category.capitalized

                            Text(label)
                                .categoryTextStyle(isSelected: isSelected)
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        viewModel.selectedCategory = category
                                    }
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                .categoryScrollViewStyle(isEmpty: viewModel.categoriesList.isEmpty)
                
                Button(action: {
                    Task {
                        await viewModel.fetchJoke()
                    }
                }, label: {
                    Label(Strings.Text.buttonText, systemImage: Strings.Image.buttonImage)
                        .buttonLabelStyle(colorScheme: colorScheme)
                })
                .disabled(viewModel.isLoading)
                
            }
            .padding(.vertical, 40)
        }
        .task {
            await viewModel.fetchCategories()
        }
    }
}

#Preview {
    ContentView()
}
