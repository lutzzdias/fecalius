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
        VStack(spacing: 0) {
            HStack {
                Text("Fecalius")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .padding(4)
                        .frame(width: 30, height: 30)
                }
                
            }
            .padding()
        }
    }
}

#Preview {
    PoopDetailSheetView(poop: Poop.mock.first!)
}
