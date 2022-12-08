//
//  LocationManager.swift
//  FlightTracker
//
//  Created by Dorra Ben Abdelwahed on 7/12/2022.
//

import MapKit


class LocationManager: NSObject, ObservableObject{
    
    private let locationManager = CLLocationManager()
    
    @Published var region: MKCoordinateRegion = MKCoordinateRegion.defaultRegion()
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
}

extension LocationManager: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first, !locations.isEmpty else {return}
        
        
        self.region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 5.0, longitudeDelta: 5.0))
        
        
        locationManager.stopUpdatingLocation()
        
    }
}
