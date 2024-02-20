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
        //        MapReader { reader in
        Map(position: $position, selection: $selected) {
            ForEach(poops) { poop in
                let coord = CLLocationCoordinate2D(latitude: poop.latitude, longitude: poop.longitude)
                
                //                Annotation("", coordinate: coord) {
                //                    Image(systemName: "toilet.circle")
                //                        .resizable()
                //                        .frame(width: 40, height: 40)
                //                }.tag(poop.id)
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
        .onChange(of: selected) {
            print(selected?.location)
        }
        .sheet(isPresented: .constant(true)) {
            HomeSheetView(selected: $selected)
                .presentationDetents([.tenth, .third, .full], selection: .constant(.third))
                .presentationBackgroundInteraction(.enabled(upThrough: .third))
                .interactiveDismissDisabled()
                .presentationBackground(.thickMaterial)
        }
        .task {
            try? await locationService.requestUserLocation()
            try? await locationService.startLocationUpdates()
        }
        //            .onTapGesture { screenCoord in
        //                let tapCoord = reader.convert(screenCoord, from: .local)
        //                // TODO: Create new poop (?)
        //                print(tapCoord.debugDescription)
        //            }
        //        }
    }
}

#Preview {
    MapView()
        .modelContainer(for: [User.self, Poop.self], inMemory: true)
}
