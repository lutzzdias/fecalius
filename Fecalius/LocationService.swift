//
//  LocationService.swift
//  Fecalius
//
//  Created by Thiago Lütz Dias on 18/02/24.
//

import MapKit

@Observable
class LocationService: NSObject, CLLocationManagerDelegate {
    
    private var locationManager: CLLocationManager?
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
            isLocationDisabled = true
            
        case .authorizedAlways, .authorizedWhenInUse:
            isLocationDisabled = false
            
        @unknown default:
            isLocationDisabled = true
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}


