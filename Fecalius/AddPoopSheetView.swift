//
//  AddPoopSheetView.swift
//  Fecalius
//
//  Created by Thiago Lütz Dias on 16/02/24.
//

import SwiftUI

struct AddPoopSheetView: View {
    @Environment(\.dismiss) var dismiss
    @State var location: String = ""
    @State var observations: String = ""
    @State var timestamp: Date = Date.now
    @State var rating: Int = 0
    
    var body: some View {
        Form {
            Section("Test") {
                
                HStack {
                    Text("Location")
                    Spacer()
                    TextField("Home", text: $location)
                        .frame(width: 200)
                }
                
                DatePicker("Date", selection: $timestamp)
            }
            
            Section("Rating") {
                HStack {
                    ForEach(1 ..< 5 + 1, id: \.self) { number in
                        Button {
                            rating = number
                            print(rating)
                        } label: {
                            number > rating ?
                            Image(systemName: "star")
                                .foregroundStyle(Color.yellow)
                            : Image(systemName: "star.fill")
                                .foregroundStyle(Color.yellow)
                        }
                    }
                }
                .buttonStyle(.plain)
            }
            
            Section("Observations") {
                TextEditor(text: $observations)
                    .frame(minHeight: 100, maxHeight: 350)
            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    print("saved")
                }
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    print("cancelled")
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddPoopSheetView()
}
