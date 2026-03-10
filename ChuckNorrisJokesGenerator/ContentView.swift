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
                
                Spacer()
                
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
    }
}

#Preview {
    ContentView()
}
