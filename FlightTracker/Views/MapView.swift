//
//  HomeView.swift
//  FlightTracker
//
//  Created by Dorra Ben Abdelwahed on 7/12/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @StateObject var locationManager = LocationManager()
    @StateObject var viewModel = HomeViewModel()
    @State var isShowing = false
  
   
   
    var body: some View {
        
        Map(coordinateRegion: $locationManager.region, interactionModes: .all, annotationItems: viewModel.locations){ location in
            MapAnnotation(coordinate: location.coordinate) {
               
                   
                    Image(systemName: "airplane")
                        .foregroundColor(.yellow)
                        .rotationEffect(Angle(degrees: location.direction))
                        .onTapGesture {
                            
                            viewModel.selectLocation(plane: location)
                            isShowing.toggle()
                          
                        }
                
               

               
                    
                    
                    

            }
            
           
        }
        .onAppear {
            Task{
                await viewModel.fetchFlights()
            }
        }
            .ignoresSafeArea()
            .sheet(isPresented: $isShowing) {
                PlaneDetailsView(flight: viewModel.selectedLocation!)
                    .presentationDetents([.fraction(0.15)])
            }
           
           
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
