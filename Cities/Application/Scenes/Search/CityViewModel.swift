//
//  CityViewModel.swift
//  Cities
//
//  Created by Chittapon Thongchim on 12/9/2565 BE.
//

import MapKit

struct CityViewModel: Comparable {

    let name: String
    let title: String?
    let subtitle: String?
    let city: City
    
    init(city: City) {
        self.city = city
        name = city.name
        title = "\(city.name), \(city.country)"
        subtitle = "\(city.coordinate.lat), \(city.coordinate.lon)"
    }
    
    func toAnnotation() -> CityAnnotation {
        CityAnnotation(city: city)
    }
    
    static func make(searchText: String) -> Self {
        let city = City(country: "", name: searchText, id: 0, coordinate: .init(lat: 0, lon: 0))
        return CityViewModel(city: city)
    }
    
    // MARK: - Comparable
    
    static func < (lhs: CityViewModel, rhs: CityViewModel) -> Bool {
        return lhs.name.lowercased() < rhs.name.lowercased()
    }
    
    static func == (lhs: CityViewModel, rhs: CityViewModel) -> Bool {
        return lhs.name.lowercased().hasPrefix(rhs.name.lowercased())
    }
}

final class CityAnnotation: NSObject, MKAnnotation {
    
    let city: City
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    
    init(city: City) {
        self.city = city
        title = "\(city.name), \(city.country)"
        subtitle = "\(city.coordinate.lat), \(city.coordinate.lon)"
        coordinate = CLLocationCoordinate2D(latitude: city.coordinate.lat, longitude: city.coordinate.lon)
    }
    
}
