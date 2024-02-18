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
    
    func checkLocationIsEnabled() {
        DispatchQueue.global().async {
            guard CLLocationManager.locationServicesEnabled() else {
                // TODO: Show error alert
                print("error, whole location is disabled")
                return
            }
            
            self.locationManager = CLLocationManager()
            self.locationManager!.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager!.delegate = self
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            //TODO: show alert (error?)
            print("your location is restricted, likely due to parental controls")
        case .denied:
            // TODO: alert error
            print("you have denied this app location permission. go into settings to change it")
        case .authorizedAlways, .authorizedWhenInUse:
            // TODO: not force unwrap
            region = MKCoordinateRegion(
                center: locationManager.location!.coordinate,
                span: MapDetails.defaultSpan
            )
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}


