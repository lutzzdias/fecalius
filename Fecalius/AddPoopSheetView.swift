//
//  AddPoopSheetView.swift
//  Fecalius
//
//  Created by Thiago Lütz Dias on 16/02/24.
//

import SwiftUI

struct AddPoopSheetView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @State var location: String = ""
    @State var observations: String = ""
    @State var timestamp: Date = Date.now
    @State var rating: Int = 0
    
    var body: some View {
        Form {
            // Add Location component
            
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
                            Image(systemName: number > rating ? "star" : "star.fill")
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
                    // TODO: latitude, longitude and user
                    let poop = Poop(
                        latitude: 0,
                        longitude: 0,
                        location: location,
                        observations: observations,
                        rating: rating,
                        timestamp: timestamp,
                        user: User(username: "lutzzdias")
                    )
                    context.insert(poop)
                    dismiss()
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
