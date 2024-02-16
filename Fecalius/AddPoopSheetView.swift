//
//  AddPoopSheetView.swift
//  Fecalius
//
//  Created by Thiago Lütz Dias on 16/02/24.
//

import SwiftUI

struct AddPoopSheetView: View {
    @State var location: String = ""
    @State var observations: String = ""
    @State var timestamp: Date = Date.now
    
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
                }
            }
        }
    }
}

#Preview {
    AddPoopSheetView()
}
