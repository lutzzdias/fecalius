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
    @State var locationName: String = ""
    @State var observations: String = ""
    @State var timestamp: Date = Date.now
    @State var rating: Double = 0
    
    let locationService = LocationService.shared
    
    var body: some View {
        Form {
            Section("Location") {
                    TextField("Home", text: $locationName)
            }
                
            Section {
                DatePicker("Date", selection: $timestamp)
            }
            
            Section("Rating") {
                RatingView(rating: $rating)
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
                    guard let coords = locationService.location?.coordinate else {
                        // TODO: handle no coordinates
                        print("coordinates not available")
                        return
                    }
                    
                    do {
                        let location = try Location.fetchOrCreate(name: locationName, coordinate: coords, context: context)
                        
                        let poop = Poop(
                            location: location,
                            observations: observations,
                            rating: rating,
                            timestamp: timestamp
                        )
                        
                        context.insert(poop)
                        dismiss()
                    } catch {
                        print("Failed to fetch or create location: \(error)")
                    }
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
