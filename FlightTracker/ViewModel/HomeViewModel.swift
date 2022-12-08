//
//  HomeViewModel.swift
//  FlightTracker
//
//  Created by Dorra Ben Abdelwahed on 7/12/2022.
//

import Foundation
import SwiftUI
import MapKit
import Combine

class HomeViewModel: ObservableObject{
    
    private(set) var flights: [Flights.Data] = []
    
    @Published var region = MKCoordinateRegion()
    @Published var selectedLocation: Location?
    
    let locationManager = LocationManager()
    var cancellables = Set<AnyCancellable>()
    
    @Published var locations: [Location] = []
  
    
    func selectLocation(plane: Location){
        selectedLocation = plane
    }
    
    func fetchFlights() async {
        
        let url_string = "\(baseURL)?access_key=\(accessKey)&limit=100"
        
        guard let url = URL(string: url_string) else {fatalError("missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        do{
            let (data,response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { fatalError("Error while fetching data") }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(Flights.self, from: data)
            
            self.flights = decodedData.data
            
            DispatchQueue.main.async {
                
                self.locations = self.flights.map{
                    Location(name: $0.flight.icaoNumber, coordinate: CLLocationCoordinate2D(latitude: $0.geography.latitude, longitude: $0.geography.longitude),direction: $0.geography.direction,status: $0.status, arrival: $0.arrival.iataCode, depart: $0.departure.iataCode)
                }
            }
            
        } catch {
            print("Error fetching trivia: \(error)")
        }
        
    }
}
