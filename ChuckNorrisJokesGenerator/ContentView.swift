//
//  ContentView.swift
//  ChuckNorrisJokesGenerator
//
//  Created by Pall Arnold Barna on 10.03.2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = JokeViewModel()
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("💪 Chuck Norris")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Text("Joke Generator")
                    .font(.title2)
                    .foregroundColor(.orange)
                
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white.opacity(0.1))
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
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(24)
                    }
                }
                .frame(minHeight: 200)
                .padding(.horizontal)
                
                Spacer()
                
                Button(action: {
                    Task {
                        await viewModel.fetchJoke()
                    }
                }, label: {
                    Label("Get a Joke", systemImage: "bolt.fill")
                        .font(.headline)
                        .foregroundColor(.black)
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
    }
}

#Preview {
    ContentView()
}
