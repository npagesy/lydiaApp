//
//  MapView.swift
//  lydia
//
//  Created by Noeline PAGESY on 05/08/2022.
//

import MapKit
import UIKit

final class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, locationName: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        super.init()
    }
    
    var subtitle: String? { locationName }
}

class MapView: MKMapView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(with address: Address) {
        super.init(frame: .zero)
        
        layer.cornerRadius = 15.0
        if let latitude = CLLocationDegrees(address.latitude), let longitude = CLLocationDegrees(address.longitude) {
            centerToLocation(CLLocation(latitude: latitude, longitude: longitude))
            
            let artwork = Artwork(title: "\(address.streetNumber.description) \(address.streetName)",
                                  locationName: "\(address.postCode), \(address.city)",
                                  coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            addAnnotation(artwork)
        }
    }
}

// MARK: - Private function
private extension MKMapView {
    func centerToLocation(
        _ location: CLLocation,
        regionRadius: CLLocationDistance = 1000
      ) {
        let coordinateRegion = MKCoordinateRegion(
          center: location.coordinate,
          latitudinalMeters: regionRadius,
          longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
      }
}
