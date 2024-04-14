//
//  ContentView.swift
//  Fecalius
//
//  Created by Thiago Lütz Dias on 14/02/24.
//

import SwiftUI
import SwiftData
import MapKit

struct MapView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(Poop.all) private var poops: [Poop]
    
    @State var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State var selected: Poop?
    
    let locationService = LocationService.shared
    
    // TODO: Handle position not shared
    var body: some View {
        Map(position: $position, selection: $selected) {
            ForEach(poops) { poop in
                let coord = CLLocationCoordinate2D(latitude: poop.latitude, longitude: poop.longitude)

                Marker(coordinate: coord) {
                    Image(systemName: "toilet.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                }.tag(poop)
            }
        }
        .mapStyle(.standard(elevation: .realistic))
        .mapControlVisibility(.automatic)
        .mapControls {
            MapUserLocationButton()
            MapPitchToggle()
            MapCompass()
            MapScaleView(anchorEdge: .leading)
                .mapControlVisibility(.automatic)
        }
        .sheet(isPresented: .constant(true)) {
            HomeSheetView(poop: $selected)
                .id("home")
                .presentationDetents([.tenth, .third, .full], selection: .constant(.third))
                .presentationBackgroundInteraction(.enabled(upThrough: .third))
                .interactiveDismissDisabled()
                .presentationBackground(.thickMaterial)
        }
        .task {
            try? await locationService.requestUserLocation()
            try? await locationService.startLocationUpdates()
        }
    }
}

#Preview {
    MapView()
        .modelContainer(for: [Poop.self], inMemory: true)
}
