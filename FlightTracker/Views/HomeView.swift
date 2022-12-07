//
//  HomeView.swift
//  FlightTracker
//
//  Created by Dorra Ben Abdelwahed on 7/12/2022.
//

import SwiftUI
import MapKit

struct HomeView: View {
    
    @StateObject var locationManager = LocationManager()
    @State var tracking:MapUserTrackingMode = .follow
   
    var body: some View {
        Map(coordinateRegion: $locationManager.region, interactionModes: .all, showsUserLocation: true,userTrackingMode: $tracking)
            .ignoresSafeArea()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
