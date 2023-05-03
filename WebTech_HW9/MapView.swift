//
//  MapView.swift
//  WebTech_HW9
//
//  Created by Mehvish Akhtar on 02/05/23.
//

import SwiftUI
import CoreLocation
import MapKit

struct VenueLocation: Identifiable {
  var id = UUID()
  let name: String
  let latitude: Double
  let longitude: Double
  
  var coordinate: CLLocationCoordinate2D {
    CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }
}

struct MapView: View {
    var lat: Double
    var long: Double
    @State var venueName: String
      
      var body: some View {
        let venueLocation = [VenueLocation(name: venueName, latitude: lat, longitude: long)]
          @State var coordinateRegion = MKCoordinateRegion( center: CLLocationCoordinate2D(latitude: lat, longitude: long), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
          
        Map(coordinateRegion: $coordinateRegion, annotationItems: venueLocation) { place in
            MapMarker(coordinate: place.coordinate, tint: .red)
        }
        .padding(20)
      }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let latitude = Double("56.951924")!
        let longitude = Double("24.125584")!
        MapView(lat: latitude, long: longitude, venueName: "")
    }
}
