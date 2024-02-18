//
//  ContentView.swift
//  Fecalius
//
//  Created by Thiago Lütz Dias on 14/02/24.
//

import SwiftUI
import SwiftData
import MapKit

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @State var showingSheet = true
    @State var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    @Bindable
    var locationService = LocationService()
    
    // TODO: Handle position not shared
    var body: some View {
        Map(position: $position)
            .mapStyle(.standard(elevation: .realistic))
            .mapControlVisibility(.automatic)
            .mapControls {
                MapUserLocationButton()
                MapPitchToggle()
                MapCompass()
                MapScaleView(anchorEdge: .leading)
                    .mapControlVisibility(.automatic)
            }
            .sheet(isPresented: $showingSheet) {
                HomeSheetView()
                    .presentationDetents([.tenth, .third, .full])
                    .presentationBackgroundInteraction(.enabled(upThrough: .third))
                    .interactiveDismissDisabled()
                    .presentationBackground(.thickMaterial)
            }
            .onAppear {
                locationService.requestLocation()
            }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: [User.self, Poop.self], inMemory: true)
}
