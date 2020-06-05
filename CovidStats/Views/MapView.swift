//
//  MapView.swift
//  CovidStats
//
//  Created by Isa  Selimi on 18.5.20.
//  Copyright © 2020 com.isaselimi. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    
    @Binding var countryData: [CountryData]
    let locationManager = CLLocationManager()
    var filterBy: String
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        
        uiView.showsUserLocation = true
        var allAnnotations: [CoronaCaseAnnotation] = []
        
        for data in countryData {
            var title = data.country + "\n" + data.confirmed.formatNumber()
            switch  filterBy {
            case "Deaths":
                title += "\n" + data.deaths.formatNumber()
            case "Recovered":
                title += "\n" + data.recovered.formatNumber()
            case "Confirmed":
                 title += "\n" + data.confirmed.formatNumber()
            default:
               title += "\n" + data.deaths.formatNumber()
            }
            let coordinate = CLLocationCoordinate2D(latitude: data.latitude, longitude: data.longitute)
            allAnnotations.append(CoronaCaseAnnotation(title: title, coordinate: coordinate))
        }
        
        uiView.annotations.forEach { uiView.removeAnnotation($0) }
        uiView.addAnnotations(allAnnotations)
    }
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        return MKMapView()
    }
}

class CoronaCaseAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}
