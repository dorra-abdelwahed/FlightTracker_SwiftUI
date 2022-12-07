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
    @StateObject var viewModel = HomeViewModel()
    
   
    var body: some View {
        
        Map(coordinateRegion: $locationManager.region, interactionModes: .all, annotationItems: viewModel.locations){ location in
            MapAnnotation(coordinate: location.coordinate) {
                
                Image(systemName: "airplane")
                    .foregroundColor(.yellow)
                    .rotationEffect(Angle(degrees: location.direction))
                    .onTapGesture {
                                print("Tapped on \(location.name)")
                            }
                    
                    

            }
        }
        .onAppear {
            Task{
                await viewModel.fetchFlights()
            }
        }
            .ignoresSafeArea()
           
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
