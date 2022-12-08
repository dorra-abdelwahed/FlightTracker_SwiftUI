//
//  HomeViewModel.swift
//  FlightTracker
//
//  Created by Dorra Ben Abdelwahed on 7/12/2022.
//

import SwiftUI
import CoreData


class HomeViewModel: ObservableObject{
    
    @Published var flights: [Flights.Data] = []
    @Published var selectedFlight: Flights.Data?
    private var timer: Timer?
 
    
    init() {
        
           ///API Data is being updated every 10 minutes
//           timer = Timer.scheduledTimer(withTimeInterval: 10*60, repeats: true) { _ in
//               Task {
//                   self.fetchFlights(context:)
//               }
//           }
       }
    
    //Saving Remote Data to CoreData
    func saveData(context: NSManagedObjectContext){
        
        flights.forEach { data in
            
            let entity = FlightsModel(context: context)
            entity.name = data.flight.icaoNumber
            entity.status = data.status
            entity.latitude = data.geography.latitude
            entity.longitude = data.geography.longitude
            entity.arrival = data.arrival.iataCode
            entity.depart = data.departure.iataCode
            entity.direction = data.geography.direction
            
        }
        
        do{
            try context.save()
            print("success")
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func selectFlights(flight: Flights.Data){
        selectedFlight = flight
    }
    
    //fetched api data
    func fetchFlights(context: NSManagedObjectContext) async {
        
        let url_string = "\(baseURL)?access_key=\(accessKey)&limit=100"
        
        guard let url = URL(string: url_string) else {fatalError("missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        do{
            let (data,response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { fatalError("Error while fetching data") }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(Flights.self, from: data)
            
            
            DispatchQueue.main.async {
                
                self.flights = decodedData.data
                self.saveData(context: context)
            }
            
        } catch {
            print("Error fetching: \(error)")
        }
        
    }
}
