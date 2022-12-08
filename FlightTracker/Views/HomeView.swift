//
//  HomeView.swift
//  FlightTracker
//
//  Created by Dorra Ben Abdelwahed on 7/12/2022.
//

import SwiftUI
import MapKit
import CoreData

struct HomeView: View {
    
    @StateObject var locationManager = LocationManager()
    @StateObject var viewModel = HomeViewModel()
    @ObservedObject var networkManager = NetworkManager()
    
    @State var isShowing = false
    @State private var showingAlert = false
    
    @EnvironmentObject var manager: DataManager
    @Environment(\.managedObjectContext) private var context
    
    //Fetching Data from Core Data
    @FetchRequest(entity: FlightsModel.entity(), sortDescriptors: [])
    var results : FetchedResults<FlightsModel>
    
    
    var body: some View {
        
        ZStack{
            if !networkManager.isConnected {
                
                
                ProgressView()
                    .onAppear{
                        showingAlert = true
                    }
                
                Map(coordinateRegion: $locationManager.region, interactionModes: .all, annotationItems: results){ flight in
                    
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: flight.latitude, longitude: flight.longitude)) {
                        
                        
                        Image(systemName: "airplane")
                            .foregroundColor(.yellow)
                            .rotationEffect(Angle(degrees: flight.direction))
                        
                        
                        
                    }
                    
                    
                }
            }
            else {
                
                Map(coordinateRegion: $locationManager.region, interactionModes: .all, annotationItems: viewModel.flights){ flight in
                    
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: flight.geography.latitude, longitude: flight.geography.longitude)) {
                        
                        
                        Image(systemName: "airplane")
                            .foregroundColor(.yellow)
                            .rotationEffect(Angle(degrees: flight.geography.direction))
                            .onTapGesture {
                                
                                viewModel.selectFlights(flight: flight)
                                isShowing.toggle()
                                
                            }
                    }
                }
                .onAppear {
                    
                    Task{
                        await viewModel.fetchFlights(context: context)
                    }
                    
                }
            }
        }
        .sheet(isPresented: $isShowing) {
            FlightDetails(flight: viewModel.selectedFlight!)
                .presentationDetents([.fraction(0.15)])
        }
        .alert("It looks like you're not connected!", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
        .ignoresSafeArea()
        
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
