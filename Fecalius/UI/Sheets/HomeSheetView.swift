//
//  HomeSheetView.swift
//  Fecalius
//
//  Created by Thiago Lütz Dias on 14/02/24.
//

import SwiftUI
import SwiftData

struct HomeSheetView: View {
    @Environment(\.modelContext) private var context
//    @Query(Poop.all) private var poops: [Poop]
    let poops = Poop.mock
    
    @State var showingAddPoopSheet = false
    @State var showingAllPoopsSheet = false
    
    @Binding var poop: Poop?
    
    var body: some View {
        VStack(spacing: 0) {
            SheetHeader(title: "Fecalius", subtitle: nil) {
                Button {
                    showingAddPoopSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .padding(4)
                        .frame(width: 30, height: 30)
                }
            }
            
            List {
                VerticalSection(header:
                    poops.count > 3 ?
                    SectionHeader(title: "Recents", actionTitle: "More") { showingAllPoopsSheet.toggle() }
                    : SectionHeader(title: "Recents")     
                )
                
                HorizontalSection(header: SectionHeader(title: "Most common locations"))
            }
            .scrollContentBackground(.hidden)
            
            Spacer()
        }
//        .sheet(isPresented: $showingAddPoopSheet) {
//            NavigationStack {
//                AddPoopSheetView()
//            }
//        }
//        .sheet(isPresented: $showingAllPoopsSheet) {
//            NavigationStack {
//                AllPoopsSheetView()
//            }
//        }
//        .sheet(item: $poop) { poop in
//            PoopDetailSheetView(poop: poop)
//                .id(poop.id)
//                .presentationDetents([.tenth, .third, .full], selection: .constant(.third))
//                .presentationBackgroundInteraction(.enabled(upThrough: .third))
//                .interactiveDismissDisabled()
//                .presentationBackground(.ultraThickMaterial)
//        }
    }
    
    @ViewBuilder
    func VerticalSection(header: some View) -> some View {
        // TODO: Align content with header (remove margin (?))
        
        Section {
            if(poops.count > 0) {
                ForEach(poops.prefix(3)) { p in
                    Button {
                        withAnimation {
                            poop = p
                        }
                        
                    } label: {
                        PoopRowView(poop: p)
                            .foregroundStyle(.black)
                    }
                }
            } else {
                Button {
                    showingAddPoopSheet.toggle()
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add new poop")
                    }
                }
            }
        } header: { header }
    }
    
    @ViewBuilder
    func HorizontalSection(header: some View) -> some View {
        // TODO: Align content with header (remove margin (?))
        
        Section {
            ScrollView(.horizontal) {
                HStack(alignment: .top, spacing: 24) {
                    IconItemView(title: "Home", icon: "house.fill", details: "55 poops")
                    IconItemView(title: "Home", icon: "house.fill", details: "55 poops")
                    IconItemView(title: "Home", icon: "house.fill", details: "55 poops")
                    IconItemView(title: "Add", icon: "plus")
                }
            }
        } header: { header }
    }
}

#Preview {
    HomeSheetView(poop: .constant(nil))
        .modelContainer(for: [Poop.self], inMemory: true)
}
