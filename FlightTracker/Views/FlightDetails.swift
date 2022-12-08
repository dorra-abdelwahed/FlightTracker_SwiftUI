//
//  PlaneDetailsView.swift
//  FlightTracker
//
//  Created by Dorra Ben Abdelwahed on 7/12/2022.
//

import SwiftUI
import CoreLocation

struct FlightDetails: View {
    
    var flight: Flights.Data
    
    var body: some View {
        
        
        
        VStack(alignment: .leading){
            
            HStack{
                
                Text(flight.flight.icaoNumber)
                    .font(.headline)
                    .fontWeight(.black)
                
                Spacer()
                
                Text(flight.status)
                    .font(.headline)
                    .fontWeight(.black)
                    .foregroundColor(.yellow)
                
            }
            .padding(.horizontal, 50)
            
            HStack{
                Text(flight.departure.iataCode)
                    .bold()
                Spacer()
                
                Image(systemName: "airplane.circle")
                    .resizable()
                    .foregroundColor(.yellow)
                    .frame(width: 30, height:  30)
                
                Spacer()
                Text(flight.arrival.iataCode)
                    .bold()
            }
            .padding(.horizontal, 50)
        }
        .padding()
        
        
        
    }
}

