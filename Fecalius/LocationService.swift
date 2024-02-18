//
//  LocationService.swift
//  Fecalius
//
//  Created by Thiago Lütz Dias on 18/02/24.
//

import MapKit

enum MapDetails {
    static let defaultLocation = CLLocationCoordinate2D(latitude: 37.331516, longitude: -121.891054)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25)
}

@Observable
class LocationService: NSObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    var region = MKCoordinateRegion(
        center: MapDetails.defaultLocation,
        span: MapDetails.defaultSpan
    )
    var isLocationDisabled = true
    
    func requestLocation() {
        locationManager = CLLocationManager()
        locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        locationManager!.delegate = self
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .restricted, .denied:
            // Disable location features
            isLocationDisabled = true
            
        case .authorizedAlways, .authorizedWhenInUse:
            // TODO: not force unwrap
            region = MKCoordinateRegion(
                center: locationManager.location!.coordinate,
                span: MapDetails.defaultSpan
            )
            isLocationDisabled = false
            
        @unknown default:
            isLocationDisabled = true
        }
        
        print(isLocationDisabled)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}


