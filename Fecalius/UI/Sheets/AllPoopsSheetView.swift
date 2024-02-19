//
//  AllPoopsSheetView.swift
//  Fecalius
//
//  Created by Thiago Lütz Dias on 19/02/24.
//

import SwiftUI
import SwiftData

struct AllPoopsSheetView: View {
    @Environment(\.dismiss) private var dismiss
    @Query(Poop.all) private var poops: [Poop]
    
    private var classified: Poop.classifiedPoops { Poop.classified(poops) }
    
    var body: some View {
        List {
            if (!classified.sameDay.isEmpty) {
                Section("Today") {
                    ForEach(classified.sameDay) { poop in
                        PoopRowView(poop: poop)
                    }
                }
            }
            
            if (!classified.sameMonth.isEmpty) {
                Section("This Month") {
                    ForEach(classified.sameMonth) { poop in
                        PoopRowView(poop: poop)
                    }
                }
            }
            
            if (!classified.older.isEmpty) {
                Section("Older") {
                    ForEach(classified.older) { poop in
                        PoopRowView(poop: poop)
                    }
                }
            }
        }
        .navigationTitle("All")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AllPoopsSheetView()
        .modelContainer(for: [User.self, Poop.self], inMemory: true)
}
