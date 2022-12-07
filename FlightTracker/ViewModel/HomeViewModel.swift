//
//  HomeViewModel.swift
//  FlightTracker
//
//  Created by Dorra Ben Abdelwahed on 7/12/2022.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject{
    
    private(set) var flights: [Flights.Data] = []
    
    func fetchFlights() async {
        
        let url_string = "\(baseURL)?access_key=\(accessKey)"
        
        guard let url = URL(string: url_string) else {fatalError("missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        do{
            let (data,response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { fatalError("Error while fetching data") }
            
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(Flights.self, from: data)
            
            self.flights = decodedData.data
            print(self.flights)
            
        } catch {
            print("Error fetching trivia: \(error)")
        }
        
    }
}
