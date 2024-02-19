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
    
    @Query(Poop.all) private var poops: [Poop]
    
    @State var showingSheet = true
    @State var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    let locationService = LocationService.shared
    
    // TODO: Handle position not shared
    var body: some View {
        MapReader { reader in
            Map(position: $position) {
                ForEach(poops) { poop in
                    let coord = CLLocationCoordinate2D(latitude: poop.latitude, longitude: poop.longitude)
                    Marker(poop.location, systemImage: "mappin", coordinate: coord)
                    
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
            .onTapGesture { screenCoord in
                let tapCoord = reader.convert(screenCoord, from: .local)
                // TODO: Create new poop (?)
                print(tapCoord)
            }
            .sheet(isPresented: $showingSheet) {
                HomeSheetView()
                    .presentationDetents([.tenth, .third, .full])
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
}

#Preview {
    HomeView()
        .modelContainer(for: [User.self, Poop.self], inMemory: true)
}
