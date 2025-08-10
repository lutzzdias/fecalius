//
//  PoopDetailView.swift
//  Fecalius
//
//  Created by Thiago Lütz Dias on 19/02/24.
//

import SwiftUI

struct PoopDetailSheetView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    let poop: Poop
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SheetHeader(title: poop.location, subtitle: poop.date) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .padding(4)
                        .frame(width: 30, height: 30)
                        .foregroundStyle(.gray)
                }
            }
            
            Form {
                Section("Rating") {
                    RatingView(rating: .constant(poop.rating))
                }
                
                if let observations = poop.observations {
                    if (!observations.isEmpty) {
                        Section("Observations") {
                            Text(observations)
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            
            Spacer()
        }
    }
}

#Preview {
    PoopDetailSheetView(poop: Poop.mock.first!)
}
