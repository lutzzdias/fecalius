//
//  HomeSheetView.swift
//  Fecalius
//
//  Created by Thiago Lütz Dias on 14/02/24.
//

import SwiftUI

struct HomeSheetView: View {
    @State var showingAddPoopSheet = false
    
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
                    ForEach(Poop.mock.prefix(3)) { poop in
                        HStack {
                            Image(systemName: "mappin.circle.fill")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .aspectRatio(contentMode: .fit)
                                .foregroundStyle(.red.gradient)
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Home")
                                        .fontWeight(.semibold)
                                    Spacer()
                                    HStack {
                                        Image(systemName: "star.fill")
                                            .resizable()
                                            .frame(width: 16, height: 16)
                                        Image(systemName: "star.fill")
                                            .resizable()
                                            .frame(width: 16, height: 16)
                                        Image(systemName: "star.fill")
                                            .resizable()
                                            .frame(width: 16, height: 16)
                                        Image(systemName: "star.fill")
                                            .resizable()
                                            .frame(width: 16, height: 16)
                                        Image(systemName: "star")
                                            .resizable()
                                            .frame(width: 16, height: 16)
                                    }
                                }
                                
                                Text(Date.now.formatted(date: .abbreviated, time: .shortened))
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                } header: {
                    HStack {
                        Text("Recents")
                            .font(.body)
                            .fontWeight(.semibold)
                            .textCase(nil)
                            .presentationBackground(.ultraThickMaterial)
                        
                        Spacer()
                        
                        Button {
                            print("more")
                        } label: {
                            Text("More")
                                .font(.body)
                                .textCase(nil)
                                .foregroundStyle(.link)
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    .padding(.bottom, 8)
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
    }
}

#Preview {
    HomeView()
        .modelContainer(for: [User.self, Poop.self], inMemory: true)
}
