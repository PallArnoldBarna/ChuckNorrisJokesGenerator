//
//  ViewExtensions.swift
//  ChuckNorrisJokesGenerator
//
//  Created by Pall Arnold Barna on 11.03.2026.
//

import Foundation
import SwiftUI

extension Image {
    func logoStyle() -> some View {
        self.resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300)
            .padding(.top, -30)
    }
}

extension Text {
    func titleStyle(colorScheme: ColorScheme) -> some View {
        self.multilineTextAlignment(.center)
            .font(.title)
            .bold()
            .foregroundColor(colorScheme == .dark ? .white : .black)
    }
    
    func jokeBoxTextStyle(colorScheme: ColorScheme) -> some View {
        self.font(.title3)
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .multilineTextAlignment(.center)
            .padding(24)
    }
    
    func categoryTextStyle(isSelected: Bool) -> some View {
        self.font(.subheadline.weight(isSelected ? .bold : .regular))
            .foregroundColor(isSelected ? .black : .orange)
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(isSelected ? Color.orange : Color.clear)
            )
            .overlay(
                Capsule()
                    .strokeBorder(Color.orange, lineWidth: 1.5)
            )
    }
}

extension Rectangle {
    func jokeBoxStyle(colorScheme: ColorScheme) -> some View {
        self.fill(colorScheme == .dark ? .white.opacity(0.1) : .black.opacity(0.1))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.orange, lineWidth: 1.5)
            )
            .cornerRadius(20)
    }
}

extension ProgressView {
    func progressViewStyle() -> some View {
        self.tint(.orange)
            .scaleEffect(1.5)
    }
}

extension ZStack {
    func jokeBoxSize() -> some View {
        self.frame(minHeight: 200)
            .padding(.horizontal)
    }
}

extension Label {
    func buttonLabelStyle(colorScheme: ColorScheme) -> some View {
        self.font(.headline)
            .foregroundColor(colorScheme == .dark ? .black : .white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(.orange)
            .cornerRadius(14)
            .padding(.horizontal)
    }
}

extension ScrollView {
    func categoryScrollViewStyle(isEmpty: Bool) -> some View {
        self.frame(height: 44)
            .overlay {
                if isEmpty {
                    ProgressView().tint(.orange)
                }
            }
    }
    
    func jokeBoxScrollViewStyle() -> some View {
        self.defaultScrollAnchor(.center, for: .alignment)
            .scrollBounceBehavior(.basedOnSize)
    }
}
