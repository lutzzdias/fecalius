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
    @Query(Poop.all) private var poops: [Poop]
    
    @State var showingAddPoopSheet = false
    @State var showingAllPoopsSheet = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Fecalius")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                Button {
                    showingAddPoopSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .padding(4)
                        .frame(width: 30, height: 30)
                }
                
            }
            .padding()
            
            List {
                Section {
                    if(poops.count > 0) {
                        ForEach(poops.prefix(3)) { poop in
                            PoopRowView(poop: poop)
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
                } header: {
                    poops.count > 3 ?
                    SectionHeader(title: "Recents", actionTitle: "More") {
                        showingAllPoopsSheet.toggle()
                    }
                    : SectionHeader(title: "Recents")
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            
            Spacer()
        }
        .sheet(isPresented: $showingAddPoopSheet) {
            NavigationStack {
                AddPoopSheetView()
            }
        }
        .sheet(isPresented: $showingAllPoopsSheet) {
            NavigationStack {
                AllPoopsSheetView()
            }
        }
    }
    
    @ViewBuilder
    func SectionHeader(title: String, actionTitle: String? = nil, actionCallback: (() -> Void)? = nil) -> some View {
        HStack {
            Text(title)
                .font(.body)
                .fontWeight(.semibold)
                .textCase(nil)
                .presentationBackground(.ultraThickMaterial)
            
            Spacer()
            
            if let actionTitle, (actionCallback != nil)  {
                Button(action: actionCallback!, label: {
                    Text(actionTitle)
                        .font(.body)
                        .textCase(nil)
                        .foregroundStyle(.link)
                })
            }
                
        }
        .listRowInsets(EdgeInsets())
        .padding(.bottom, 8)
    }
}

#Preview {
    HomeView()
        .modelContainer(for: [User.self, Poop.self], inMemory: true)
}
