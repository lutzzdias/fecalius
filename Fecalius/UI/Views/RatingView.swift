//
//  RatingView.swift
//  Fecalius
//
//  Created by Thiago Lütz Dias on 19/02/24.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Double
    @State private var lastTappedIndex: Int? = nil
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: getStarSymbol(for: index))
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundStyle(.yellow)
                    .onTapGesture { handleTap(at: index) }
            }
        }
    }
    
    private func getStarSymbol(for index: Int) -> String {
        if rating >= Double(index) {
            return "star.fill"
        } else if rating >= Double(index) - 0.5 {
            return "star.leadinghalf.filled"
        } else {
            return "star"
        }
    }
    
    private func handleTap(at index: Int) {
        if lastTappedIndex == index {
            if rating == Double(index) {
                rating = Double(index) - 0.5
            } else {
                rating = Double(index)
            }
        } else {
            rating = Double(index)
        }
        lastTappedIndex = index
    }
}


#Preview {
    VStack(spacing: 10) {
        RatingView(rating: .constant(0.0))   // all empty
        RatingView(rating: .constant(0.5))   // half first star
        RatingView(rating: .constant(2.0))   // 2 full stars
        RatingView(rating: .constant(3.5))   // 3 full, 1 half
        RatingView(rating: .constant(5.0))   // all full
    }
    .padding()
}
