//
//  Flights.swift
//  FlightTracker
//
//  Created by Dorra Ben Abdelwahed on 7/12/2022.
//

import Foundation


struct Flights: Codable{
    
    var data: [Data]
    
    struct Data: Codable, Identifiable{
        
        // We need to set the ID inside of the closure, because the API doesn' return us an ID for each result
        var id: UUID {
            UUID()
        }
        let status: String
        let arrival: Airport
        let departure: Airport
        let flight: Flight
        let geography: Geography
    }
    
}

struct Flight: Codable{
    
    let icaoNumber: String
}

struct Geography: Codable{
    
    let altitude: Double
    let direction: Double
    let latitude: Double
    let longitude: Double
    
}

struct Airport: Codable{
    let iataCode: String
}

