//
//  PlaneDetailsView.swift
//  FlightTracker
//
//  Created by Dorra Ben Abdelwahed on 7/12/2022.
//

import SwiftUI
import CoreLocation

struct PlaneDetailsView: View {
    
    var flight: Location
    
    var body: some View {
        
      
            
            VStack(alignment: .leading){
                
                HStack{
                    
                    Text(flight.name)
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
                    Text(flight.depart)
                        .bold()
                    Spacer()
                    
                    Image(systemName: "airplane.circle")
                        .resizable()
                        .foregroundColor(.yellow)
                        .frame(width: 30, height:  30)
                    
                    Spacer()
                    Text(flight.arrival)
                        .bold()
                }
                .padding(.horizontal, 50)
            }
            .padding()
            
          
        
    }
}

struct PlaneDetailsView_Previews: PreviewProvider {
    static var previews: some View {
      
        PlaneDetailsView(flight: Location(name: "UAL497", coordinate: CLLocationCoordinate2D(latitude: 42.83, longitude: -115.03), direction: 297.65, status: "En route", arrival: "BOI", depart: "DEN"))
    }
}
