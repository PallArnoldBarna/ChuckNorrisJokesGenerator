//
//  ContentView.swift
//  ChuckNorrisJokesGenerator
//
//  Created by Pall Arnold Barna on 10.03.2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = JokeViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            colorScheme == .dark ? Color.black.ignoresSafeArea() : Color.white.ignoresSafeArea()
            
            VStack(spacing: 30) {
                Image("chucknorris_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
                    .padding(.top, -40)
                
                Text("Chuck Norris Joke Generator")
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .bold()
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.orange, lineWidth: 1.5)
                        )
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(.orange)
                            .scaleEffect(1.5)
                    } else {
                        Text(viewModel.errorMessage ?? viewModel.joke)
                            .font(.title3)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .multilineTextAlignment(.center)
                            .padding(24)
                    }
                }
                .frame(minHeight: 200)
                .padding(.horizontal)
                
                HStack {
                    Text("Category:")
                    
                    Picker("Category", selection: $viewModel.selectedCategory) {
                        ForEach(viewModel.categoriesList, id: \.self) { category in
                            Text(category.capitalized).tag(category)
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(.orange)
                    .disabled(viewModel.categoriesList.isEmpty)
                    .overlay {
                        if viewModel.categoriesList.isEmpty {
                            ProgressView().tint(.orange)
                        }
                    }
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        let allCategories = viewModel.categoriesList

                        ForEach(allCategories, id: \.self) { category in
                            let isSelected = viewModel.selectedCategory == category
                            let label = category == "random" ? "Random" : category.capitalized

                            Text(label)
                                .font(.subheadline.weight(isSelected ? .bold : .regular))
                                .foregroundColor(isSelected ? .black : .orange)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 8)
                                .background(
                                    Capsule()
                                        .fill(isSelected ? Color.orange : Color.clear)
                                )
                                .overlay(
                                    Capsule()
                                        .stroke(Color.orange, lineWidth: 1.5)
                                )
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        viewModel.selectedCategory = category
                                    }
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(height: 44)
                .overlay {
                    if viewModel.categoriesList.isEmpty {
                        ProgressView().tint(.orange)
                    }
                }
                
                Menu {
                    Picker("Category", selection: $viewModel.selectedCategory) {
                        //Text("Random").tag("random")
                        ForEach(viewModel.categoriesList, id: \.self) { category in
                            Text(category.capitalized).tag(category)
                        }
                    }
                } label: {
                    HStack {
                        Image(systemName: "list.bullet")
                        Text(viewModel.selectedCategory == "random"
                             ? "Random"
                             : viewModel.selectedCategory.capitalized)
                        Spacer()
                        Image(systemName: "chevron.down")
                    }
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.orange)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white.opacity(0.1))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.orange, lineWidth: 1.5)
                            )
                    )
                    .padding(.horizontal)
                }
                .disabled(viewModel.categoriesList.isEmpty)
                
                Button(action: {
                    Task {
                        await viewModel.fetchJoke()
                    }
                }, label: {
                    Label("Get a Joke", systemImage: "bolt.fill")
                        .font(.headline)
                        .foregroundColor(colorScheme == .dark ? .black : .white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.orange)
                        .cornerRadius(14)
                        .padding(.horizontal)
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
