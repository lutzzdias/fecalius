//
//  RatingView.swift
//  Fecalius
//
//  Created by Thiago Lütz Dias on 19/02/24.
//

import SwiftUI

struct RatingView: View {
    let rating: Int
    
    var body: some View {
        HStack {
            ForEach(0..<5) { number in
                Image(systemName: number >= rating ? "star" : "star.fill")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundStyle(Color.yellow)
            }
        }
    }
}

#Preview {
    RatingView(rating: 4)
}
