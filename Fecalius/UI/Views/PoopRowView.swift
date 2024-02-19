//
//  PoopRowView.swift
//  Fecalius
//
//  Created by Thiago Lütz Dias on 19/02/24.
//

import SwiftUI

struct PoopRowView: View {
    let poop: Poop
    
    var body: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .frame(width: 32, height: 32)
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.red.gradient)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(poop.location)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    HStack {
                        ForEach(0..<5) { number in
                            Image(systemName: number > (poop.rating ?? 0) ? "star" : "star.fill")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundStyle(Color.yellow)
                        }
                    }
                }
                
                Text(poop.timestamp.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    PoopRowView(poop: Poop.mock.first!)
}
