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
            SameDaySection()
            
            SameMonthSection()
            
            OlderSection()
        }
        .navigationTitle("All")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
    
    @ViewBuilder
    func SameDaySection() -> some View {
        if (!classified.sameDay.isEmpty) {
            Section("Today") {
                ForEach(classified.sameDay) { poop in
                    PoopRowView(poop: poop)
                }
            }
        }
    }
    
    @ViewBuilder
    func SameMonthSection() -> some View {
        if (!classified.sameMonth.isEmpty) {
            Section("This Month") {
                ForEach(classified.sameMonth) { poop in
                    PoopRowView(poop: poop)
                }
            }
        }
    }
    
    @ViewBuilder
    func OlderSection() -> some View {
        if (!classified.older.isEmpty) {
            Section("Older") {
                ForEach(classified.older) { poop in
                    PoopRowView(poop: poop)
                }
            }
        }
    }

    
    
}

#Preview {
    AllPoopsSheetView()
        .modelContainer(for: [Poop.self, Location.self], inMemory: true)
}
