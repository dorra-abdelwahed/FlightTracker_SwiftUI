//
//  MKCoordinateRegion.swift
//  FlightTracker
//
//  Created by Dorra Ben Abdelwahed on 8/12/2022.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    
    static func defaultRegion() -> MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.33233141, longitude: -122.03121860), span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))
    }

}
