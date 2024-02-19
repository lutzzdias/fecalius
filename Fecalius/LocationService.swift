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
    
    var location: CLLocation? = nil
    
    func requestUserLocation() async throws {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startLocationUpdates() async throws {
        for try await locationUpdate in CLLocationUpdate.liveUpdates() {
            guard let location = locationUpdate.location else { return }
            
            self.location = location
        }
    }
}


