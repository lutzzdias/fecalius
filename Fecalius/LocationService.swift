//
//  LocationService.swift
//  Fecalius
//
//  Created by Thiago Lütz Dias on 18/02/24.
//

import MapKit
import Observation

@Observable
class LocationService {
    
    static let shared = LocationService()
    
    private let locationManager = CLLocationManager()
    
    var location: CLLocation?
    
    // TODO: handle authorization denied
    func requestUserLocation() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startLocationUpdates() async throws {
        for try await update in CLLocationUpdate.liveUpdates() {
            if let loc = update.location {
                self.location = loc
            } else {
                // TODO: handle no location
            }
        }
    }
}
