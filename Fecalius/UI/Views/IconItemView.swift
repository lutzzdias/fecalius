//
//  IconItemView.swift
//  Fecalius
//
//  Created by Thiago Lütz Dias on 14/04/24.
//

import SwiftUI

// TODO: Transform into button and receive callback
// TODO: Allow color customization

struct IconItemView: View {
    let title: String
    let icon: String
    var details: String? = nil
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .frame(width: 64, height: 64)
                    .foregroundStyle(.red.gradient)
                
                
                Image(systemName: icon)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.white)
            }
            
            VStack(spacing: 2) {
                Text(title)
                    .lineLimit(2)
                    .fontWeight(.semibold)
                
                if let details {
                    Text(details)
                        .lineLimit(1)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

#Preview {
    IconItemView(title: "Location", icon: "house.fill", details: "100 poops")
}
