//
//  CityViewModel.swift
//  Cities
//
//  Created by Chittapon Thongchim on 12/9/2565 BE.
//

import MapKit

@objcMembers
final class CityViewModel: NSObject, MKAnnotation {
    
    let name: String
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    let city: City
    
    init(city: City) {
        self.city = city
        name = city.name
        title = "\(city.name), \(city.country)"
        subtitle = "\(city.coordinate.lat), \(city.coordinate.lon)"
        coordinate = CLLocationCoordinate2D(latitude: city.coordinate.lat, longitude: city.coordinate.lon)
    }
    
}
